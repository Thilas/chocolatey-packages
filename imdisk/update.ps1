param([switch] $Force)

Import-Module au

function global:au_GetLatest {
  $baseUrl        = 'http://www.ltr-data.se'
  $releasesPath   = 'opencode.html'

  $fileType       = 'exe'
  $silentArgs     = '-y'
  $validExitCodes = '0'

  $uninstallSoftwareName   = 'ImDisk *'
  $uninstallFileType       = 'exe'
  $uninstallSilentArgs     = '-y'
  $uninstallValidExitCodes = '0'

  $releasesUrl = (New-Object System.Uri([System.Uri]($baseUrl), $releasesPath)).ToString()
  $releases = Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing
  $version = $releases.Content -Match 'Current version (.+) built'
  if (!$version) { Throw [System.InvalidOperationException]'Version invalid.' }
  $version = $Matches[1]

  $urls = @($releases.Links | Where-Object href -Like "*$version*.$fileType")
  if ($urls.Length -ne 1) { Throw [System.InvalidOperationException]'Url not found.' }
  $url = (New-Object System.Uri([System.Uri]($baseUrl), $urls[0].href)).ToString()

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
