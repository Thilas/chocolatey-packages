param([switch] $Force)

Import-Module au

function global:au_GetLatest {
  $releasesUrl    = 'http://serviio.org/download'

  $fileType       = 'exe'
  $silentArgs     = '/S'
  $validExitCodes = '0'

  $uninstallSoftwareName   = 'Serviio'
  $uninstallFileType       = 'exe'
  $uninstallSilentArgs     = '/S'
  $uninstallValidExitCodes = @(0)

  $releases = Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing
  $version = $releases.Content -Match 'The latest released version is ([^ ]+) '
  if (!$version) { Throw [System.InvalidOperationException]'Version invalid.' }
  $version = $Matches[1]

  $urls = @($releases.Links | Where-Object href -Like "*$version*.$fileType")
  if ($urls.Length -ne 1) { Throw [System.InvalidOperationException]'Url not found.' }
  $url = $urls[0].href

  return @{
    Version = $version
    Url32 = $url
    FileType = $fileType
    SilentArgs = $silentArgs
    ValidExitCodes = $validExitCodes
    UninstallSoftwareName = $uninstallSoftwareName
    UninstallFileType = $uninstallFileType
    UninstallSilentArgs = $uninstallSilentArgs
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
      "^([$]softwareName\s*=\s*)'.*'$"      = "`$1'$($Latest.UninstallSoftwareName)'"
      "^([$]packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
      "^([$]fileType\s*=\s*)'.*'$"          = "`$1'$($Latest.UninstallFileType)'"
      "^([$]silentArgs\s*=\s*)'.*'$"        = "`$1'$($Latest.UninstallSilentArgs)'"
      "^([$]validExitCodes\s*=\s*)@\(.*\)$" = "`$1@($($Latest.UninstallValidExitCodes))"
    }
  }
}

Update-Package -ChecksumFor 32 -Force:$Force
