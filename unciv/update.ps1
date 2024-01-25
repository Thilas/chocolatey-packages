[CmdletBinding()]
param([switch] $Force)

. "$PSScriptRoot\..\Common.ps1"

function global:au_GetLatest {
    Get-GitHubLatest `
        -Repository 'yairm210/Unciv' `
        -FileType 'zip' `
        -IsUri64 { param($Uri) $Uri -match '\bWindows64\b' }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            '^(\s*file64\s*=\s*)".*"$'      = '$1"$toolsDir\{0}"' -f $Latest.FileName64
        }
        'tools\chocolateyBeforeModify.ps1' = @{
            '^(\s*zipFileName\s*=\s*)".*"$' = '$1"{0}"' -f $Latest.FileName64
        }
        'legal\VERIFICATION.txt' = @{
            '(?i)(\s+x64:).*'               = '$1 {0}' -f $Latest.Url64
            '(?i)(checksum64:).*'           = '$1 {0}' -f $Latest.Checksum64
        }
    }
}

Update-Package -ChecksumFor none -Force:$Force
