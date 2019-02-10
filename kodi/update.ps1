[CmdletBinding()]
param([switch] $Force)

. "$PSScriptRoot\..\Common.ps1"

function global:au_GetLatest {
    return Get-LinksLatest -ReleasesUrl 'https://mirrors.kodi.tv/releases/windows/win32/', 'https://mirrors.kodi.tv/releases/windows/win64/' `
                           -GetVersion { param($Url)
                               $versionPattern = '-(?<Version>\d+(?:\.\d+){1,3})-'
                               $value = if ($Url -match "$versionPattern.+_(?<Prerelease>[0-9A-Za-z-]+(?:\.[0-9A-Za-z-]+| \d+)*)-") {
                                   $prerelease = $Matches.Prerelease.Replace(' ', '.')
                                   # for now, chocolatey does only support SemVer v1 (no dot separated identifiers in pre-release):
                                   if ($prerelease -match '\.') { return }
                                   #
                                   '{0}-{1}' -f $Matches.Version, $prerelease
                               } elseif ($Url -match $versionPattern) {
                                   $Matches.Version
                               } else {
                                   $Url
                               }
                               return Get-Version $value
                           } `
                           -FileType 'exe' `
                           -IsUrl32 { param($Url) $Url -like '*x86*' } `
                           -IsUrl64 { param($Url) $Url -like '*x64*' } `
                           -Latest @{
                               SoftwareName            = 'Kodi*'
                               SilentArgs              = '/S'
                               ValidExitCodes          = '0'
                               UninstallFileType       = 'exe'
                               UninstallSilentArgs     = '/S'
                               UninstallValidExitCodes = '0'
                           }
}

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1'   = @{
            "^(\s*packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
            "^(\s*softwareName\s*=\s*)'.*'$"      = "`$1'$($Latest.SoftwareName)'"
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
            "^([$]softwareName\s*=\s*)'.*'$"      = "`$1'$($Latest.SoftwareName)'"
            "^([$]fileType\s*=\s*)'.*'$"          = "`$1'$($Latest.UninstallFileType)'"
            "^([$]silentArgs\s*=\s*)'.*'$"        = "`$1'$($Latest.UninstallSilentArgs)'"
            "^([$]validExitCodes\s*=\s*)@\(.*\)$" = "`$1@($($Latest.UninstallValidExitCodes))"
        }
    }
}

Update-Package -ChecksumFor all -Force:$Force
