﻿[CmdletBinding()]
param([switch] $Force)

. "$PSScriptRoot\..\Common.ps1"

function global:au_GetLatest {
    # HTTPS doesn't work as of today (2023-06-07)
    $url = 'http://www.ltr-data.se/opencode.html'
    try {
        Invoke-WebRequest -Uri $url -UseBasicParsing -Method Head | Out-Null
    } catch {
        if ($_.Exception.Response.StatusCode -eq 503) {
            Write-Warning 'Site is unavailable'
            $nuspec = [xml] (Get-Content "*.nuspec")
            return @{ Version = $nuspec.package.metadata.version } # Fallback to latest version when the site is unavailable
        }
        throw
    }
    $latest = Get-BasicLatest `
        -ReleaseUri $url `
        -TagNamePattern 'Current version (?<TagName>.+?) (built|packaged)' `
        -FileType 'exe' `
        -SkipTagName `
        -IsUri32 { param($Uri, $TagName, $Uris)
            $pattern = "_{0}\b" -f [regex]::Escape($TagName)
            if ($Uris | Where-Object { $_ -match $pattern}) {
                # Normal case: version is part of the url
                return $Uri -match $pattern
            }
            # Abnormal case: no url contains the version
            return $Uri -match "/imdiskinst.exe$"
        } `
        -Latest @{
            SoftwareName   = 'ImDisk *'
            SilentArgs     = '-y'
            ValidExitCodes = '0'
        }
    # If the url does not contain the version, let's check if it works
    $pattern = "_{0}\b" -f [regex]::Escape($latest.Version)
    if ($latest.Url32 -notmatch $pattern) {
        try {
            Invoke-WebRequest -Method Head -Uri $latest.Url32 -UseBasicParsing | Out-Null
        } catch {
            # If not, we'll try to guess another one containing the version
            $latest.Url32 = [uri]::new($latest.Url32, 'imdiskinst_{0}.exe' -f $latest.Version)
        }
    }
    return $latest
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "^(\s*packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
            "^(\s*softwareName\s*=\s*)'.*'$"      = "`$1'$($Latest.SoftwareName)'"
            "^(\s*fileType\s*=\s*)'.*'$"          = "`$1'$($Latest.FileType)'"
            "^(\s*silentArgs\s*=\s*)'.*'$"        = "`$1'$($Latest.SilentArgs)'"
            "^(\s*validExitCodes\s*=\s*)@\(.*\)$" = "`$1@($($Latest.ValidExitCodes))"
        }
        'tools\chocolateyUninstall.ps1' = @{
            "^([$]packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
            "^([$]softwareName\s*=\s*)'.*'$"      = "`$1'$($Latest.SoftwareName)'"
        }
        'legal\VERIFICATION.txt' = @{
            "(?i)(\s+x32:).*"                     = "`$1 $($Latest.Url32)"
            "(?i)(checksum32:).*"                 = "`$1 $($Latest.Checksum32)"
        }
    }
}

Update-Package -ChecksumFor none -Force:$Force
