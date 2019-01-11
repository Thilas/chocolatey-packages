[CmdletBinding()]
param([switch] $Force)

. "$PSScriptRoot\..\Common.ps1"

function global:au_GetLatest {
    # no 32-bits version for now (see https://github.com/VSCodium/vscodium/issues/66)
    return Get-GitHubLatest -Repository 'VSCodium/vscodium' `
                            -FileType 'exe' `
                            -IsUrl32 { param($Url) $Url -like '*VSCodiumSetup-*' } `
                            -IsUrl64 { param($Url) $Url -like '*VSCodiumSetup-x64*' } `
                            -Latest @{
                                SoftwareName            = 'VSCodium'
                                SilentArgs              = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
                                ValidExitCodes          = '0, 3010, 1641'
                            }
}

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1'   = @{
            "^([$]softwareName\s*=\s*)'.*'$"      = "`$1'$($Latest.SoftwareName)'"
            "^([$]version\s*=\s*)'.*'$"           = "`$1'$($Latest.Version)'"
            "^(\s*packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
            "^(\s*fileType\s*=\s*)'.*'$"          = "`$1'$($Latest.FileType)'"
            # "^(\s*url\s*=\s*)'.*'$"               = "`$1'$($Latest.Url32)'"
            "^(\s*url64bit\s*=\s*)'.*'$"          = "`$1'$($Latest.Url64)'"
            "^(\s*silentArgs\s*=\s*)'.*'$"        = "`$1'$($Latest.SilentArgs)'"
            # "^(\s*checksum\s*=\s*)'.*'$"          = "`$1'$($Latest.Checksum32)'"
            # "^(\s*checksumType\s*=\s*)'.*'$"      = "`$1'$($Latest.ChecksumType32)'"
            "^(\s*checksum64\s*=\s*)'.*'$"        = "`$1'$($Latest.Checksum64)'"
            "^(\s*checksumType64\s*=\s*)'.*'$"    = "`$1'$($Latest.ChecksumType64)'"
            "^(\s*validExitCodes\s*=\s*)@\(.*\)$" = "`$1@($($Latest.ValidExitCodes))"
        }
    }
}

Update-Package -ChecksumFor all -Force:$Force
