[CmdletBinding()]
param([switch] $Force)

. "$PSScriptRoot\..\Common.ps1"

function global:au_GetLatest {
    Get-BasicLatest `
        -ReleaseUrl 'http://www.ltr-data.se/opencode.html' `
        -TagNamePattern 'Current version (?<TagName>.+) built' `
        -FileType 'exe' `
        -Latest @{
            SoftwareName            = 'ImDisk *'
            SilentArgs              = '-y'
            ValidExitCodes          = '0'
        }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1'   = @{
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
            "(?i)(\s+x32:).*"                     = "`${1} $($Latest.Url32)"
            "(?i)(checksum32:).*"                 = "`${1} $($Latest.Checksum32)"
        }
    }
}

Update-Package -ChecksumFor none -Force:$Force
