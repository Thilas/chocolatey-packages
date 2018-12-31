[CmdletBinding()]
param([switch] $Force)

. "$PSScriptRoot\..\Common.ps1"

function global:au_GetLatest {
    return Get-GitHubLatest -Repository 'icsharpcode/ILSpy' `
                            -GetTagName { param($TagName)
                                $TagName -replace '-final$', ''
                            } `
                            -FileType 'zip' `
                            -IsUrl32 { param($Url, $TagName, $Version) $Url -like '*binaries*' }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "^(\s*packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
            "^([$]fileType\s*=\s*)'.*'$"          = "`$1'$($Latest.FileType)'"
        }
        'legal\VERIFICATION.txt' = @{
            "(?i)(\s+x32:).*"                     = "`${1} $($Latest.Url32)"
            "(?i)(checksum32:).*"                 = "`${1} $($Latest.Checksum32)"
        }
    }
}

Update-Package -ChecksumFor none -Force:$Force
