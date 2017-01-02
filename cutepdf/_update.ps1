param([switch] $Force)

Import-Module au

function global:au_GetLatest {
  $fileType       = 'exe'
  $url32          = 'http://www.cutepdf.com/download/CuteWriter.exe'
  $silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  $validExitCodes = '0'

  $releasesUrl = 'http://www.cutepdf.com/products/cutepdf/writer.asp'
  $releases = Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing
  $version = $releases.Content -Match '\(Ver\. (?<version>[^ ]+);'
  if (!$version) { Throw [System.InvalidOperationException]'Version invalid.' }
  $version = $Matches['version']

  return @{
    Version                 = $version
    FileType                = $fileType
    Url32                   = $url32
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
      "^(\s*silentArgs\s*=\s*)'.*'$"        = "`$1'$($Latest.SilentArgs)'"
      "^(\s*checksum\s*=\s*)'.*'$"          = "`$1'$($Latest.Checksum32)'"
      "^(\s*checksumType\s*=\s*)'.*'$"      = "`$1'$($Latest.ChecksumType32)'"
      "^(\s*validExitCodes\s*=\s*)@\(.*\)$" = "`$1@($($Latest.ValidExitCodes))"
    }
  }
}

Update-Package -ChecksumFor 32 -Force:$Force
