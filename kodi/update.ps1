[CmdletBinding()]
param([switch] $Force)

. "$PSScriptRoot\..\Common.ps1"

function global:au_GetLatest {
    $releaseUrl = 'https://api.github.com/repos/xbmc/xbmc/releases/latest'
    $release = (Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing).Content | ConvertFrom-Json
    $tagName = $release.tag_name -replace '-.+$'
    Write-Verbose ("TagName: {0}" -f $tagName)
    $version = Get-Version $tagName
    Write-Verbose ("Version: {0}" -f $version)

    $downloadUrl = 'https://kodi.tv/download/849'
    $download = Invoke-WebRequest -Uri $downloadUrl -UseBasicParsing

    $links = $download.Links
    $links = $links | ? { $_.href -like "*{0}*{1}*.exe" -f $version.Version, $version.Prerelease }

    $urls = @($links | ? { $_.href -like '*win32*' } | % { $_.href } | select -Unique)
    if ($urls.Length -ne 1) { throw 'Url (x86) not found.' }
    $url32 = Get-Url $downloadUrl $urls[0]
    Write-Verbose ("Url32: {0}" -f $url32)
    $urls = @($links | ? { $_.href -like '*win64*' } | % { $_.href } | select -Unique)
    if ($urls.Length -gt 0) {
        if ($urls.Length -ne 1) { throw 'Url (x64) not found.' }
        $url64 = Get-Url $downloadUrl $urls[0]
        Write-Verbose ("Url64: {0}" -f $url64)
    } else {
        $url64 = $url32
    }

    return @{
        Version                 = $version
        Url32                   = $url32
        Url64                   = $url64
        SilentArgs              = '/S'
        ValidExitCodes          = '0'
        UninstallSoftwareName   = 'Kodi*'
        UninstallFileType       = 'exe'
        UninstallSilentArgs     = '/S'
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
