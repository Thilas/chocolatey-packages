param([switch] $Force)

function getLatest {
  $fileType       = 'exe'
  $silentArgs     = '/S'
  $checksumType   = 'sha256'
  $validExitCodes = '0'

  $uninstallValidExitCodes = '0'

  $releasesUrl = 'https://api.github.com/repos/gurnec/HashCheck/releases/latest'
  $releases = (Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing).Content | ConvertFrom-Json
  $version = $releases.tag_name -Match '^v(?<version>.+)$'
  if (!$version) { throw 'Version not found.' }
  $version = $Matches['version']

  $urls = @($releases.assets | ? name -Like "*$version*.$fileType")
  if ($urls.Length -ne 1) { throw 'Url not found.' }
  $url = $urls[0].browser_download_url

  $urls = @($releases.assets | ? name -Like "*$version*.$checksumType")
  if ($urls.Length -ne 1) { throw 'Checksum url not found.' }
  $checksumUrl = $urls[0].browser_download_url
  $checksum = (New-Object System.Net.WebClient).DownloadString($checksumUrl)
  $checksum = $checksum -Match '^(?<checksum>.+) \*'
  if (!$checksum) { throw 'Checksum not found.' }
  $checksum = $Matches['checksum']

  return @{
    Version                 = $version
    FileType                = $fileType
    Url32                   = $url
    SilentArgs              = $silentArgs
    Checksum32              = $checksum
    ChecksumType32          = $checksumType
    ValidExitCodes          = $validExitCodes
    UninstallValidExitCodes = $uninstallValidExitCodes
  }
}

function searchReplace {
  @{
    'tools\chocolateyInstall.ps1' = @{
      "^(\s*packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
      "^(\s*fileType\s*=\s*)'.*'$"          = "`$1'$($Latest.FileType)'"
      "^(\s*url\s*=\s*)'.*'$"               = "`$1'$($Latest.Url32)'"
      "^(\s*silentArgs\s*=\s*)'.*'$"        = "`$1'$($Latest.SilentArgs)'"
      "^(\s*checksum\s*=\s*)'.*'$"          = "`$1'$($Latest.Checksum32)'"
      "^(\s*checksumType\s*=\s*)'.*'$"      = "`$1'$($Latest.ChecksumType32)'"
      "^(\s*validExitCodes\s*=\s*)@\(.*\)$" = "`$1@($($Latest.ValidExitCodes))"
    }
    'tools\chocolateyUninstall.ps1' = @{
      "^([$]packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
      "^([$]validExitCodes\s*=\s*)@\(.*\)$" = "`$1@($($Latest.UninstallValidExitCodes))"
    }
  }
}

. '..\Update-Package.ps1' -ChecksumFor none -Force:$Force
