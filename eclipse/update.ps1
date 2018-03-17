[CmdletBinding()]
param([switch] $Force)

. "$PSScriptRoot\..\Common.ps1"

function global:au_GetLatest {
    $latest = Get-BasicLatest -ReleaseUrl 'https://www.eclipse.org/downloads/eclipse-packages/?osType=win32' `
                              -TagNamePattern 'Eclipse .+ \((?<tagName>[^)]+)\) +Release' `
                              -SkipTagName `
                              -FileType 'zip' `
                              -IsUrl32 { param($Url) $Url -like "*jee*" -and $Url -notlike '*x86_64*' } `
                              -IsUrl64 { param($Url) $Url -like "*jee*" -and $Url -like '*x86_64*' }
    $latest.Url32 += '&r=1'
    $latest.Url64 += '&r=1'
    return $latest
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

Update-Package -ChecksumFor all -Force:$Force
