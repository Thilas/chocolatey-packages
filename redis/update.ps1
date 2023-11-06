[CmdletBinding()]
param([switch] $Force)

. "$PSScriptRoot\..\Common.ps1"

function global:au_GetLatest {
    Get-GitHubLatest `
        -Repository 'redis-windows/redis-windows' `
        -StreamFieldCount 2 `
        -FileType 'tar.gz' `
        -IsUri64 { param($Uri) $Uri -match '\bx64\b' -and $Uri -notmatch '-with-Service\b' }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix

    $7z   = "$Env:ChocolateyInstall\tools\7z.exe"
    $file = Get-Item 'tools\*.tar.gz'
    if (!$file) {
        throw 'File is missing.'
    }
    if ($file -is [array]) {
        throw 'Multiple files found.'
    }
    cmd "/c `"`"`"$7z`"`" x `"`"$file`"`" -so | `"`"$7z`"`" x -si -ttar`""
    Remove-Item 'tools' -Recurse -Force
    $directory = [System.IO.Path]::GetFileNameWithoutExtension([io.Path]::GetFileNameWithoutExtension($file))
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
