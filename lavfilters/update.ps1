param([switch] $Force)

Import-Module au

function global:au_GetLatest {
  $releasesUrl    = 'https://api.github.com/repos/Nevcairiel/LAVFilters/releases/latest'

  $fileType       = 'exe'
  $silentArgs     = '/SILENT'
  $validExitCodes = '0'

  $uninstallSoftwareName   = 'LAV Filters *'
  $uninstallFileType       = 'exe'
  $uninstallSilentArgs     = '/SILENT'
  $uninstallValidExitCodes = '0'

  $releases = (Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing).Content | ConvertFrom-Json
  $version = $releases.tag_name -Match '^(.+)$'
  if (!$version) { Throw [System.InvalidOperationException]'Version invalid.' }
  $version = $Matches[1]

  $urls = @($releases.assets | Where-Object name -Like "*$version*.$fileType")
  if ($urls.Length -ne 1) { Throw [System.InvalidOperationException]'Url not found.' }
  $url = $urls[0].browser_download_url

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
