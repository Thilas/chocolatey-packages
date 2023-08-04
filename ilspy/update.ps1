[CmdletBinding()]
param([switch] $Force)

. "$PSScriptRoot\..\Common.ps1"

function global:au_GetLatest {
    Get-GitHubLatest `
        -Repository 'icsharpcode/ILSpy' `
        -GetTagName { param($TagName) $TagName -replace '-final$', '' } `
        -FileType 'zip' `
        -IsUri64 { param($Uri) $Uri -match '\bbinaries\b.+\bx64\b' }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "^(\s*packageName\s*=\s*)'.*'$" = "`$1'$($Latest.PackageName)'"
            "^([$]fileType\s*=\s*)'.*'$"    = "`$1'$($Latest.FileType)'"
        }
        'legal\VERIFICATION.txt' = @{
            "(?i)(\s+x64:).*"               = "`$1 $($Latest.Url64)"
            "(?i)(checksum64:).*"           = "`$1 $($Latest.Checksum64)"
        }
    }
}

Update-Package -ChecksumFor none -Force:$Force
