param([switch] $Force)

Import-Module au

function global:au_GetLatest {
  $fileType       = 'exe'
  $silentArgs     = '/S'
  $validExitCodes = '0'

  $uninstallSoftwareName   = 'Serviio'
  $uninstallFileType       = 'exe'
  $uninstallSilentArgs     = '/S'
  $uninstallValidExitCodes = '0'

  $releasesUrl = 'http://serviio.org/download'
  $releases = Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing
  $version = $releases.Content -Match 'The latest released version is (?<version>[^ ]+) '
  if (!$version) { throw 'Version not found.' }
  $version = $Matches['version']

  $urls = @($releases.Links | ? href -Like "*$version*.$fileType")
  if ($urls.Length -ne 1) { throw 'Url not found.' }
  $url = $urls[0].href

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
      "^([$]softwareName\s*=\s*)'.*'$"      = "`$1'$($Latest.UninstallSoftwareName)'"
      "^([$]fileType\s*=\s*)'.*'$"          = "`$1'$($Latest.UninstallFileType)'"
      "^([$]silentArgs\s*=\s*)'.*'$"        = "`$1'$($Latest.UninstallSilentArgs)'"
      "^([$]validExitCodes\s*=\s*)@\(.*\)$" = "`$1@($($Latest.UninstallValidExitCodes))"
    }
  }
}

Update-Package -ChecksumFor 32 -Force:$Force
