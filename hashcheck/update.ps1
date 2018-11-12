[CmdletBinding()]
param([switch] $Force)

. "$PSScriptRoot\..\Common.ps1"

function global:au_GetLatest {
    return Get-GitHubLatest -Repository 'gurnec/HashCheck' `
                            -FileType 'exe' `
                            -Latest @{
                                SilentArgs              = '/S'
                                ValidExitCodes          = '0'
                                UninstallValidExitCodes = '0'
                            }
}

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1'   = @{
            "^(\s*packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
            "^(\s*fileType\s*=\s*)'.*'$"          = "`$1'$($Latest.FileType)'"
            "^(\s*silentArgs\s*=\s*)'.*'$"        = "`$1'$($Latest.SilentArgs)'"
            "^(\s*validExitCodes\s*=\s*)@\(.*\)$" = "`$1@($($Latest.ValidExitCodes))"
        }
        'tools\chocolateyUninstall.ps1' = @{
            "^([$]packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
            "^([$]validExitCodes\s*=\s*)@\(.*\)$" = "`$1@($($Latest.UninstallValidExitCodes))"
        }
    }
}

function global:au_BeforeUpdate() { 
   Write-host "Downloading HashCheck $($Latest.Version) installer files"
   Get-RemoteFiles -Purge -NoSuffix
}

Update-Package -ChecksumFor none -Force:$Force
