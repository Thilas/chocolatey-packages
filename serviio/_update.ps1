param([switch] $Force)

Import-Module au

function global:au_GetLatest {
  $releasesUrl    = 'http://serviio.org/download'
  $fileType       = 'exe'
  $silentArgs     = '/S'
  $validExitCodes = '0'

  $releases = Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing
  $version = $releases.Content -Match 'The latest released version is ([^ ]+) '
  if (!$version) { Throw [System.InvalidOperationException]'Version invalid.' }
  $version = $Matches[1]

  $paths = @($releases.Links | Where-Object href -Like "*$version*.$fileType")
  if ($paths.Length -ne 1) { Throw [System.InvalidOperationException]'Url not found.' }
  $url = $paths[0].href

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
  }
}

Update-Package -ChecksumFor 32 -Force:$Force
