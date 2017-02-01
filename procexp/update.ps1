param([switch] $Force)

Import-Module au

function global:au_GetLatest {
  $fileType = 'zip'
  $validExitCodes = '0'

  $releasesUrl = 'https://technet.microsoft.com/en-us/sysinternals/processexplorer'
  $releases = Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing
  $version = $releases.Content -Match '>Process Explorer v(?<version>[^<]+)<'
  if (!$version) { throw 'Version not found.' }
  $version = $Matches['version']

  $urls = @($releases.Links | ? href -Like "*.$fileType" | select -Unique)
  if ($urls.Length -ne 1) { throw 'Url not found.' }
  $url = $urls[0].href

  return @{
    Version                 = $version
    Url32                   = $url
    ValidExitCodes          = $validExitCodes
  }
}

function global:au_SearchReplace {
  @{
    'tools\chocolateyInstall.ps1' = @{
      "^(\s*packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
      "^(\s*url\s*=\s*)'.*'$"               = "`$1'$($Latest.Url32)'"
      "^(\s*checksum\s*=\s*)'.*'$"          = "`$1'$($Latest.Checksum32)'"
      "^(\s*checksumType\s*=\s*)'.*'$"      = "`$1'$($Latest.ChecksumType32)'"
      "^(\s*validExitCodes\s*=\s*)@\(.*\)$" = "`$1@($($Latest.ValidExitCodes))"
    }
  }
}

Update-Package -ChecksumFor 32 -Force:$Force
