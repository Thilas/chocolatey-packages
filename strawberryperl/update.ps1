[CmdletBinding()]
param($IncludeStream, [switch] $Force)

. "$PSScriptRoot\..\Common.ps1"

function global:au_GetLatest {
    return Get-LinksLatest -ReleasesUrl 'http://strawberryperl.com/releases.html' `
                           -StreamFieldCount 2 `
                           -FileType 'msi' `
                           -IsLink { !$_.onclick } `
                           -IsUrl32 { param($Url) $Url -like '*32bit*' } `
                           -IsUrl64 { param($Url) $Url -like '*64bit*' } `
                           -Latest @{
                               SilentArgs              = '/qn /norestart'
                               ValidExitCodes          = '0, 3010, 1641'
                           }
}

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "^(\s*packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
            "^(\s*fileType\s*=\s*)'.*'$"          = "`$1'$($Latest.FileType)'"
            "^(\s*url\s*=\s*)'.*'$"               = "`$1'$($Latest.Url32)'"
            "^(\s*url64bit\s*=\s*)'.*'$"          = "`$1'$($Latest.Url64)'"
            "^(\s*silentArgs\s*=\s*)'.*'$"        = "`$1'$($Latest.SilentArgs)'"
            "^(\s*checksum\s*=\s*)'.*'$"          = "`$1'$($Latest.Checksum32)'"
            "^(\s*checksumType\s*=\s*)'.*'$"      = "`$1'$($Latest.ChecksumType32)'"
            "^(\s*checksum64\s*=\s*)'.*'$"        = "`$1'$($Latest.Checksum64)'"
            "^(\s*checksumType64\s*=\s*)'.*'$"    = "`$1'$($Latest.ChecksumType64)'"
            "^(\s*validExitCodes\s*=\s*)@\(.*\)$" = "`$1@($($Latest.ValidExitCodes))"
        }
    }
}

Update-Package -ChecksumFor all -IncludeStream $IncludeStream -Force:$Force
