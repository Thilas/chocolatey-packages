[CmdletBinding()]
param([switch] $Force)

. "$PSScriptRoot\..\Common.ps1"

function global:au_GetLatest {
    return Get-BasicLatest -ReleaseUrl 'http://www.stellarium.org/' `
                           -TagNamePattern '>latest version is (?<tagName>[^<]+)<' `
                           -FileType 'exe*' `
                           -IsUrl32 { param($Url) $Url -like '*win32*' } `
                           -IsUrl64 { param($Url) $Url -like '*win64*' } `
                           -ForceHttps `
                           -Latest @{
                               FileType                = 'exe'
                               SilentArgs              = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
                               ValidExitCodes          = '0'
                               UninstallSoftwareName   = 'Stellarium *'
                               UninstallFileType       = 'exe'
                               UninstallSilentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
                               UninstallValidExitCodes = '0'
                           }
}

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1'   = @{
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
        'tools\chocolateyUninstall.ps1' = @{
            "^([$]packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
            "^([$]softwareName\s*=\s*)'.*'$"      = "`$1'$($Latest.UninstallSoftwareName)'"
            "^([$]fileType\s*=\s*)'.*'$"          = "`$1'$($Latest.UninstallFileType)'"
            "^([$]silentArgs\s*=\s*)'.*'$"        = "`$1'$($Latest.UninstallSilentArgs)'"
            "^([$]validExitCodes\s*=\s*)@\(.*\)$" = "`$1@($($Latest.UninstallValidExitCodes))"
        }
    }
}

Update-Package -ChecksumFor all -Force:$Force
