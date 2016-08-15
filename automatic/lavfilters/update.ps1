param([switch] $Force)

Import-Module au

function global:au_GetLatest {
  $releasesUrl     = 'https://api.github.com/repos/Nevcairiel/LAVFilters/releases/latest'
  $versionPattern  = '^(.+)$'
  $fileType        = 'exe'
  $silentArgs      = '/SILENT'
  $validExitCodes  = '0'

  $releases = (Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing).Content | ConvertFrom-Json
  $version = $releases.tag_name -Match $versionPattern
  if (!$version) { Throw [System.InvalidOperationException]'Version invalid.' }
  $version = $Matches[1]

  $urls = @($releases.assets | Where-Object name -Like "*$version*.$fileType")
  if ($urls.Length -ne 1) { Throw [System.InvalidOperationException]'Url not found.' }
  $url = $urls[0].browser_download_url

  return @{ Version = $version; Url32 = $url; FileType = $fileType; SilentArgs = $silentArgs; ValidExitCodes = $validExitCodes }
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
    }
  }
}

if ($PSBoundParameters.Keys -contains 'Force') { $global:au_Force = $Force }
Update-Package -ChecksumFor 32
