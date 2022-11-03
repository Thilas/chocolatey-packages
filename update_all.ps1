# AU Packages Template: https://github.com/majkinetor/au-packages-template
param(
    [string[]] $Name,
    [switch] $Force,
    [string] $ForcedPackages,
    [string] $Root = $PSScriptRoot, # Path to the AU packages
    [switch] $ThrowOnErrors,
    [switch] $GitHubAction
)

if (Test-Path "$PSScriptRoot/update_vars.ps1") { . "$PSScriptRoot/update_vars.ps1" }
$global:au_Root = Resolve-Path $Root

$report_path  = "$PSScriptRoot\Update-AUPackages.md"
$history_path = "$PSScriptRoot\Update-History.md"
$update_info  = "$PSScriptRoot\update_info.xml"

$gist_token = if ($Env:gist_token) { $Env:gist_token } else { $Env:github_api_key }

$options = [ordered] @{
    WhatIf        = $au_WhatIf                              # Whatif all packages
    Force         = $Force                                  # Force all packages
    Timeout       = 120                                     # Connection timeout in seconds
    UpdateTimeout = 300                                     # Update timeout in seconds
    Threads       = 10                                      # Number of background jobs to use
    Push          = $Env:au_Push -eq 'true'                 # Push to chocolatey
    PushAll       = $true                                   # Allow to push multiple packages at once
    # PluginPath    = ''                                      # Path to user plugins

    IgnoreOn = @(                                           # Error message parts to set the package ignore status
        'Could not create SSL/TLS secure channel'
        'Could not establish trust relationship'
        'The operation has timed out'
        'Internal Server Error'
        'Service Temporarily Unavailable'
        'The connection was closed unexpectedly'
        'package version already exists'
        'already exists on a Simple OData Server'           #   https://github.com/chocolatey/chocolatey.org/issues/613
        'Conflict'
        'A system shutdown has already been scheduled'      #   https://gist.github.com/choco-bot/a14b1e5bfaf70839b338eb1ab7f8226f#wps-office-free
        "The term 'Write-FunctionCallLogMessage' is not recognized as a name of a cmdlet, function, script file, or executable program"
    )
    RepeatOn = @(                                           # Error message parts on which to repeat package updater
        'Could not create SSL/TLS secure channel'           #   https://github.com/chocolatey/chocolatey-coreteampackages/issues/718
        'Could not establish trust relationship'            #   -||-
        'Unable to connect'
        'The remote name could not be resolved'
        'Choco pack failed with exit code 1'                #   https://github.com/chocolatey/chocolatey-coreteampackages/issues/721
        'The operation has timed out'
        'Internal Server Error'
        'An exception occurred during a WebClient request'
        'remote session failed with an unexpected state'
        "Can't validate URL"
        'Oops, something went wrong'
        'The connection was closed unexpectedly'
        "The term 'Write-FunctionCallLogMessage' is not recognized as a name of a cmdlet, function, script file, or executable program"
        'A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond'
    )
    RepeatSleep = 60                                        # How much to sleep between repeats in seconds, by default 0
    RepeatCount = 2                                         # How many times to repeat on errors, by default 1

    Report = @{
        Type = 'markdown'                                   # Report type: markdown or text
        Path = $report_path                                 # Path where to save the report
        Params = @{                                         # Report parameters:
            Github_UserRepo = $Env:github_user_repo         #   Markdown: shows user info in upper right corner
            NoAppVeyor  = !$GitHubAction                    #   Markdown: do not show AppVeyor build shield
            Title       = ''                                #   Markdown, Text: Title of the report, by default 'Update-AUPackages'
            UserMessage = @(                                #   Markdown, Text: Custom user message to show
                "[Ignored](#ignored)"
                "[History](#update-history)"
                "[Force Test](https://gist.github.com/$Env:gist_id_test)"
                "[Releases](https://github.com/$Env:github_user_repo/tags)"
                "**TESTING AU NEXT VERSION**"
            ) -join " | "
            NoIcons     = $false                            #   Markdown: don't show icon
            IconSize    = 32                                #   Markdown: icon size
        }
    }

    History = @{
        Lines           = 90                                # Number of lines to show
        Github_UserRepo = $Env:github_user_repo             # User repo to be link to commits
        Path            = $history_path                     # Path where to save history
    }

    Gist = if ($Env:au_noGist -ne 'true') { @{
        Id     = $Env:gist_id                               # Your gist id; leave empty for new private or anonymous gist
        ApiKey = $gist_token                                # Your github api key - if empty anoymous gist is created
        Path   = $report_path, $history_path                # List of files to add to the gist
    } } else {}

    Git = @{
        User     = ''                                       # Git username, leave empty if github api key is used
        Password = $Env:github_api_key                      # Password if username is not empty, otherwise api key
    }

    GitReleases  = @{
        ApiToken    = $Env:github_api_key                   # Your github api key
        ReleaseType = 'package'                             # Either 1 release per date, or 1 release per package
    }

    RunInfo = @{
        Exclude = 'password', 'apikey', 'apitoken'          # Option keys which contain those words will be removed
        Path    = $update_info                              # Path where to save the run info
    }

    Mail = if ($Env:mail_user -and $Env:mail_pass) { @{
        To          = $Env:mail_user
        Server      = $Env:mail_server
        UserName    = $Env:mail_user
        Password    = $Env:mail_pass
        Port        = $Env:mail_port
        EnableSsl   = $Env:mail_enablessl -eq 'true'
        Attachment  = $update_info
        UserMessage = "Update status: https://gist.github.com/$Env:gist_id"
        SendAlways  = $false                                # Send notifications every time
    } } else {}

    ForcedPackages = $ForcedPackages -split ' '
    BeforeEach = {
        param($PackageName, $Options)

        $pattern = "^${PackageName}(?:\\(?<stream>[^:]+))?(?:\:(?<version>.+))?$"
        $p = $Options.ForcedPackages | Where-Object { $_ -match $pattern }
        if (!$p) { return }

        $global:au_Force         = $true
        $global:au_IncludeStream = $Matches['stream']
        $global:au_Version       = $Matches['version']
    }
}

# Enable TLS1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor "Tls12"

if ($ForcedPackages) { Write-Host "FORCED PACKAGES: $ForcedPackages" }
$global:info = Update-AuPackages -Name $Name -Options $options

if ($ThrowOnErrors -and ($global:info | Where-Object Error)) {
    Write-Error 'Errors during update'
}
