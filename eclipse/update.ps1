param([switch] $Force)

function getLatest {
  $releasesUrl = 'https://www.eclipse.org/downloads/eclipse-packages/?osType=win32'
  $releases = Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing
  $version = $releases.Content -Match 'Eclipse (?<name>\w+) \((?<version>[^ ]+)\)'
  if (!$version) { throw 'Version not found.' }
  $name = $Matches['name'].ToLowerInvariant()
  $version = $Matches['version']

  $urls = @($releases.Links | ? href -Like "*jee*$name*.zip" | ? href -NotLike '*x86_64*')
  if ($urls.Length -ne 1) { throw 'Url (x86) not found.' }
  $url32 = (New-Object System.Uri([System.Uri]($releasesUrl), $urls[0].href)).ToString() + '&r=1'
  $urls = @($releases.Links | ? href -Like "*jee*$name*.zip" | ? href -Like '*x86_64*')
  if ($urls.Length -ne 1) { throw 'Url (x64) not found.' }
  $url64 = (New-Object System.Uri([System.Uri]($releasesUrl), $urls[0].href)).ToString() + '&r=1'

  return @{
    Version                 = $version
    Url32                   = $url32
    Url64                   = $url64
  }
}

function searchReplace {
  @{
    'tools\chocolateyInstall.ps1' = @{
      "^(\s*packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
      "^(\s*url\s*=\s*)'.*'$"               = "`$1'$($Latest.Url32)'"
      "^(\s*url64bit\s*=\s*)'.*'$"          = "`$1'$($Latest.Url64)'"
      "^(\s*checksum\s*=\s*)'.*'$"          = "`$1'$($Latest.Checksum32)'"
      "^(\s*checksumType\s*=\s*)'.*'$"      = "`$1'$($Latest.ChecksumType32)'"
      "^(\s*checksum64\s*=\s*)'.*'$"        = "`$1'$($Latest.Checksum64)'"
      "^(\s*checksumType64\s*=\s*)'.*'$"    = "`$1'$($Latest.ChecksumType64)'"
    }
  }
}

. '..\Update-Package.ps1' -ChecksumFor all -Force:$Force
