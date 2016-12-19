param([switch] $Force)

Import-Module au

function global:au_GetLatest {
  $releasesUrl    = 'http://www.airserver.com/Download/MacPC'
  $fileType       = 'msi'
  $silentArgs     = '/quiet'
  $validExitCodes = '0'

  $releases = Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing

  $paths = @($releases.Links | Where-Object href -Like "*x86*.$fileType")
  if ($paths.Length -ne 1) { Throw [System.InvalidOperationException]'Url x86 not found.' }
  $url32 = $paths[0].href
  $paths = @($releases.Links | Where-Object href -Like "*x64*.$fileType")
  if ($paths.Length -ne 1) { Throw [System.InvalidOperationException]'Url x64 not found.' }
  $url64 = $paths[0].href

  $version = $url32 -Match '-([^-]+)-'
  if (!$version) { Throw [System.InvalidOperationException]'Version invalid.' }
  $version = $Matches[1]

  return @{ Version = $version; Url32 = $url32; Url64 = $url64; FileType = $fileType; SilentArgs = $silentArgs; ValidExitCodes = $validExitCodes }
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
