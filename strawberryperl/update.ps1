param([switch] $Force)

Import-Module au

function global:au_GetLatest {
  $fileType       = 'msi'
  $silentArgs     = '/qn /norestart'
  $validExitCodes = '0, 3010, 1641'

  $releasesUrl = 'http://strawberryperl.com/releases.html'
  $releases = Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing

  $urls = @($releases.Links | ? href -Like "*32bit*.$fileType" | ? onclick)
  if ($urls.Length -lt 1) { throw 'Url (x86) not found.' }
  $url32 = (New-Object System.Uri([System.Uri]($releasesUrl), $urls[0].href)).ToString()
  $urls = @($releases.Links | ? href -Like "*64bit*.$fileType" | ? onclick)
  if ($urls.Length -lt 1) { throw 'Url (x64) not found.' }
  $url64 = (New-Object System.Uri([System.Uri]($releasesUrl), $urls[0].href)).ToString()

  $version = $url32 -Match "-(?<version>[^-]+)-[^-]*32bit[^-]*\.$fileType$"
  if (!$version) { throw 'Version not found.' }
  $version = $Matches['version']

  return @{
    Version                 = $version
    FileType                = $fileType
    Url32                   = $url32
    Url64                   = $url64
    SilentArgs              = $silentArgs
    ValidExitCodes          = $validExitCodes
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
  }
}

Update-Package -ChecksumFor all -Force:$Force
