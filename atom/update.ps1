param([switch] $Force, [switch] $SkipPrerelease)

Import-Module au

function global:au_GetLatest {
  $fileType       = 'exe'
  $silentArgs     = '--silent'
  $validExitCodes = '0'

  $uninstallSoftwareName   = 'atom'
  $uninstallFileType       = 'exe'
  $uninstallSilentArgs     = '--uninstall -s'
  $uninstallValidExitCodes = '0'

  if ($SkipPrerelease) {
    $releasesUrl = 'https://api.github.com/repos/atom/atom/releases/latest'
  } else {
    $releasesUrl = 'https://api.github.com/repos/atom/atom/releases'
  }
  $releases = (Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing).Content | ConvertFrom-Json
  $releases = $releases | Select-Object -First 1
  $tag = $releases.tag_name
  $version = $tag -Match '^v(?<version>\d+(?:\.\d+)*)(?:-(?<prerelease>.+))?$'
  if (!$version) { throw 'Version not found.' }
  $version = $Matches['version']
  if ($Matches['prerelease']) { $version = "$version-$($Matches['prerelease'])" }

  $urls = @($releases.assets | ? browser_download_url -Like "*$tag*.$fileType" | ? name -NotLike '*x64*')
  if ($urls.Length -ne 1) { throw 'Url (x86) not found.' }
  $url32 = $urls[0].browser_download_url
  $urls = @($releases.assets | ? browser_download_url -Like "*$tag*x64*.$fileType")
  if ($urls.Length -ne 1) { throw 'Url (x64) not found.' }
  $url64 = $urls[0].browser_download_url

  return @{
    Version                 = $version
    FileType                = $fileType
    Url32                   = $url32
    Url64                   = $url64
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
