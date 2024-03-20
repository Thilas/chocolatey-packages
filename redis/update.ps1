[CmdletBinding()]
param([switch] $Force)

. "$PSScriptRoot\..\Common.ps1"

function global:au_GetLatest {
    Get-GitHubLatest `
        -Repository 'redis-windows/redis-windows' `
        -ReleaseFilter {
            param($Release)
            # From now on (2024-03-20), zip file is used instead of tar.gz
            # Because releases before 6.0 don't have one, we filter them out
            $version = Get-Version $Release.tag_name
            $version -ge '6.0'
        } `
        -StreamFieldCount 2 `
        -FileType 'zip' `
        -IsUri64 { param($Uri) $Uri -match '\bx64\b' -and $Uri -match '\bmsys2\b' -and $Uri -notmatch '-with-Service\b' }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix

    Set-Alias 7z "$Env:chocolateyInstall\tools\7z.exe"
    $file = Get-Item 'tools\*.zip'
    if (!$file) {
        throw 'File is missing.'
    }
    if ($file -is [array]) {
        throw 'Multiple files found.'
    }
    $directory = Split-Path $file -LeafBase
    7z x tools\*.zip
    Remove-Item 'tools' -Recurse -Force
    Move-Item $directory 'tools'
}

function global:au_SearchReplace {
    @{
        'legal\VERIFICATION.txt' = @{
            "(?i)(\s+x64:).*"               = "`$1 $($Latest.Url64)"
            "(?i)(checksum64:).*"           = "`$1 $($Latest.Checksum64)"
        }
    }
}

Update-Package -ChecksumFor none -Force:$Force
