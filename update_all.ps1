param(
    [string[]] $Name,
    [switch] $Force,
    [switch] $WhatIf,
    [string] $Root = $PSScriptRoot # Path to the AU packages
)

$global:au_Root = Resolve-Path $Root

$options = [ordered] @{
    WhatIf        = $WhatIf                                 # Whatif all packages
    Force         = $Force                                  # Force all packages
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
        "The property 'MaxIdleTime' cannot be found on this object. Verify that the property exists and can be set"
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
        'Job returned no object, Vector smash ?'
        'A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond'
        'The SSL connection could not be established'
    )
    RepeatSleep = 30                                        # How much to sleep between repeats in seconds, by default 0
    RepeatCount = 5                                         # How many times to repeat on errors, by default 1

    Report = @{
        Type = 'markdown'                                   # Report type: markdown or text
        Path = "$PSScriptRoot\report.md"                    # Path where to save the report
        Params = @{                                         # Report parameters:
            Github_UserRepo = $Env:github_user_repo         #   Markdown: shows user info in upper right corner
            NoAppVeyor  = $true                             #   Markdown: do not show AppVeyor build shield
            Title       = 'AU Report'                       #   Markdown, Text: Title of the report, by default 'Update-AUPackages'
            UserMessage = @(                                #   Markdown, Text: Custom user message to show
                "[Build](https://github.com/$Env:github_user_repo/actions)"
                "[Releases](https://github.com/$Env:github_user_repo/releases)"
            ) -join " | "
            NoIcons     = $false                            #   Markdown: don't show icon
            IconSize    = 32                                #   Markdown: icon size
        }
    }
}

# Enable TLS1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor "Tls12"

$info = Update-AuPackages -Name $Name -Options $options

if ($info | Where-Object Error) {
    Write-Error 'Errors during updates'
}

$updates = $info | Where-Object Updated | ForEach-Object {
    if ($_.Streams) {
        $_.Streams.Values | Where-Object Updated | ForEach-Object { [pscustomobject] @{
            name    = $_.Name
            version = $_.RemoteVersion
        } }
    } else {
        $_ | ForEach-Object { [pscustomobject] @{
            name    = $_.Name
            version = $_.RemoteVersion
        } }
    }
}
return $updates
