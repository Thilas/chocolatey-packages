param([switch] $Force, [switch] $SkipPrerelease)

Import-Module au

function global:au_GetLatest {
  $fileType       = 'exe'
  $silentArgs     = '/S'
  $validExitCodes = '0'

  $uninstallSoftwareName   = 'SABnzbd*'
  $uninstallFileType       = 'exe'
  $uninstallSilentArgs     = '/S'
  $uninstallValidExitCodes = '0'

  if ($SkipPrerelease) {
    $releasesUrl = 'https://api.github.com/repos/sabnzbd/sabnzbd/releases/latest'
  } else {
    $releasesUrl = 'https://api.github.com/repos/sabnzbd/sabnzbd/releases'
  }
  $releases = (Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing).Content | ConvertFrom-Json
  $releases = $releases | Select-Object -First 1
  $tag = $releases.tag_name
  $version = $tag -Match '^(?<version>[\d.]+)(?<prerelease>[^\d.].*)?$'
  if (!$version) { throw 'Version not found.' }
  $version = $Matches['version']
  if ($Matches['prerelease']) { $version = "$version-$($Matches['prerelease'])" }

  $urls = @($releases.assets | ? name -Like "*$tag*.$fileType")
  if ($urls.Length -ne 1) { throw 'Url not found.' }
  $url = $urls[0].browser_download_url

  return @{
    Version                 = $version
    FileType                = $fileType
    Url32                   = $url
    SilentArgs              = $silentArgs
    ValidExitCodes          = $validExitCodes
    UninstallSoftwareName   = $uninstallSoftwareName
    UninstallFileType       = $uninstallFileType
    UninstallSilentArgs     = $uninstallSilentArgs
    UninstallValidExitCodes = $uninstallValidExitCodes
  }
}

function global:au_SearchReplace {
  @{
    'tools\chocolateyBeforeModify.ps1' = @{
      "^([$]packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
      "^([$]softwareName\s*=\s*)'.*'$"      = "`$1'$($Latest.UninstallSoftwareName)'"
    }
    'tools\chocolateyInstall.ps1' = @{
      "^([$]packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
      "^(\s*fileType\s*=\s*)'.*'$"          = "`$1'$($Latest.FileType)'"
      "^(\s*url\s*=\s*)'.*'$"               = "`$1'$($Latest.Url32)'"
      "^(\s*silentArgs\s*=\s*)'.*'$"        = "`$1'$($Latest.SilentArgs)'"
      "^(\s*checksum\s*=\s*)'.*'$"          = "`$1'$($Latest.Checksum32)'"
      "^(\s*checksumType\s*=\s*)'.*'$"      = "`$1'$($Latest.ChecksumType32)'"
      "^(\s*validExitCodes\s*=\s*)@\(.*\)$" = "`$1@($($Latest.ValidExitCodes))"
      "^([$]softwareName\s*=\s*)'.*'$"      = "`$1'$($Latest.UninstallSoftwareName)'"
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

Update-Package -ChecksumFor 32 -Force:$Force
