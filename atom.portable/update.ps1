[CmdletBinding()]
param($IncludeStream, [switch] $Force)

. "$PSScriptRoot\..\Common.ps1"

function global:au_GetLatest {
    Get-GitHubLatest `
        -Repository 'atom/atom' `
        -StreamFieldCount 2 `
        -FileType 'zip' `
        -IsUri32 { param($Uri) $Uri -match '\batom-windows\b' } `
        -IsUri64 { param($Uri) $Uri -match '\batom-x64-windows\b' }
}

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "^(\s*packageName\s*=\s*)'.*'$"    = "`$1'$($Latest.PackageName)'"
            "^(\s*url\s*=\s*)'.*'$"            = "`$1'$($Latest.Url32)'"
            "^(\s*url64bit\s*=\s*)'.*'$"       = "`$1'$($Latest.Url64)'"
            "^(\s*checksum\s*=\s*)'.*'$"       = "`$1'$($Latest.Checksum32)'"
            "^(\s*checksumType\s*=\s*)'.*'$"   = "`$1'$($Latest.ChecksumType32)'"
            "^(\s*checksum64\s*=\s*)'.*'$"     = "`$1'$($Latest.Checksum64)'"
            "^(\s*checksumType64\s*=\s*)'.*'$" = "`$1'$($Latest.ChecksumType64)'"
        }
    }
}

Update-Package -ChecksumFor all -IncludeStream $IncludeStream -Force:$Force
