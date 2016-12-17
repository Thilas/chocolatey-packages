param([switch] $Force)

Import-Module au

function global:au_GetLatest {
  $releasesUrl    = 'https://api.github.com/repos/SubtitleEdit/subtitleedit/releases/latest'
  $fileType       = 'exe'
  $silentArgs     = '/VERYSILENT'
  $validExitCodes = '0'

  $releases = (Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing).Content | ConvertFrom-Json
  $version = $releases.tag_name -Match '^(.+)$'
  if (!$version) { Throw [System.InvalidOperationException]'Version invalid.' }
  $version = $Matches[1]

  $urls = @($releases.assets | Where-Object name -Like "*-Setup.zip")
  if ($urls.Length -ne 1) { Throw [System.InvalidOperationException]'Url not found.' }
  $url = $urls[0].browser_download_url
  $file = [IO.Path]::ChangeExtension($urls[0].name, $fileType)

  return @{ Version = $version; Url32 = $url; FileType = $fileType; File32 = $file; SilentArgs = $silentArgs; ValidExitCodes = $validExitCodes }
}

function global:au_SearchReplace {
  @{
    'tools\chocolateyInstall.ps1' = @{
      "^(\s*packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
      "^(\s*url\s*=\s*)'.*'$"               = "`$1'$($Latest.Url32)'"
      "^(\s*unzipLocation\s*=\s*).*$"       = "`$1[IO.Path]::Combine(`$env:TEMP, '$($Latest.PackageName)')"
      "^(\s*checksum\s*=\s*)'.*'$"          = "`$1'$($Latest.Checksum32)'"
      "^(\s*checksumType\s*=\s*)'.*'$"      = "`$1'$($Latest.ChecksumType32)'"
      "^(\s*fileType\s*=\s*)'.*'$"          = "`$1'$($Latest.FileType)'"
      "^(\s*file\s*=\s*).*$"                = "`$1[IO.Path]::Combine(`$env:TEMP, '$($Latest.PackageName)', '$($Latest.File32)')"
      "^(\s*silentArgs\s*=\s*)'.*'$"        = "`$1'$($Latest.SilentArgs)'"
      "^(\s*validExitCodes\s*=\s*)@\(.*\)$" = "`$1@($($Latest.ValidExitCodes))"
    }
    'tools\chocolateyUninstall.ps1' = @{
      "^([$]packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
    }
  }
}

Update-Package -ChecksumFor 32 -Force:$Force
