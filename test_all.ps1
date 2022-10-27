param(
    [string[]] $Name, # Name can be 'random N' to randomly force the Nth group of packages
    [string] $Root = $PSScriptRoot, # Path to the AU packages
    [switch] $ThrowOnErrors,
    [switch] $GitHubAction
)

if (Test-Path "$PSScriptRoot/update_vars.ps1") { . "$PSScriptRoot/update_vars.ps1" }
$global:au_Root = Resolve-Path $Root

if ($Name.Length -eq 1 -and $Name[0] -match '^random (.+)') {
    [array] $packages = Get-AuPackages

    $group = [int] $Matches[1]
    $n = Get-Random -Maximum $group
    Write-Host "TESTING GROUP $($n+1) of $group"

    $group_size = [int] ($packages.Count / $group) + 1
    $Name = $packages | Select-Object -First $group_size -Skip ($group_size * $n) | ForEach-Object Name

    Write-Host ($Name -join ' ')
    Write-Host ('-'*80)
}

$report_path = if ($null -eq $n) { "$PSScriptRoot\Update-Force-Test.md" } else { "$PSScriptRoot\Update-Force-Test-$n.md" }

$buildUrl = if ($GitHubAction) {
    "https://github.com/Thilas/chocolatey-packages/actions/workflows/main.yml"
} else {
    "https://ci.appveyor.com/project/Thilas/chocolatey-packages-ure9y"
}
$gist_token = if ($Env:gist_token) { $Env:gist_token } else { $Env:github_api_key }

$options = [ordered] @{
    Force         = $true                                   # Force all packages
    Timeout       = 120                                     # Connection timeout in seconds
    UpdateTimeout = 300                                     # Update timeout in seconds
    Threads       = 10                                      # Number of background jobs to use
    Push          = $false                                  # Push to chocolatey

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
        'Choco pack failed with exit code 1'
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
        'The connection was closed unexpectedly'
        "Can't validate URL"
        'Oops, something went wrong'
        'Job returned no object, Vector smash ?'
        "The term 'Write-FunctionCallLogMessage' is not recognized as a name of a cmdlet, function, script file, or executable program"
    )
    RepeatSleep = 60                                        # How much to sleep between repeats in seconds, by default 0
    RepeatCount = 2                                         # How many times to repeat on errors, by default 1

    Report = @{
        Type = 'markdown'                                   # Report type: markdown or text
        Path = $report_path                                 # Path where to save the report
        Params = @{                                         # Report parameters:
            Github_UserRepo = $Env:github_user_repo         #   Markdown: shows user info in upper right corner
            NoAppVeyor  = $true                             #   Markdown: do not show AppVeyor build shield
            Title       = "Update Force Test - Group ${n}"  #   Markdown, Text: Title of the report, by default 'Update-AUPackages'
            UserMessage = @(                                #   Markdown, Text: Custom user message to show
                "[Ignored](#ignored)"
                "[Update report](https://gist.github.com/$Env:gist_id)"
                "[Build]($buildUrl)"
                "**USING AU NEXT VERSION**"
            ) -join " | "
            NoIcons     = $false                            #   Markdown: don't show icon
            IconSize    = 32                                #   Markdown: icon size
        }
    }

    Gist = if ($Env:au_noGist -ne 'true') { @{
        Id     = $Env:gist_id_test                          # Your gist id; leave empty for new private or anonymous gist
        ApiKey = $gist_token                                # Your github api key - if empty anoymous gist is created
        Path   = $report_path                               # List of files to add to the gist
        Description = "Update Force Test Report #powershell #chocolatey"
    } } else {}
}

# Enable TLS1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor "Tls12"

$global:info = Update-AuPackages -Name $Name -Options $options

if ($ThrowOnErrors -and ($global:info | Where-Object Error)) {
    Write-Error 'Errors during test'
}
