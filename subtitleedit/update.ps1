param([switch] $Force)

Import-Module au

function global:au_GetLatest {
  $fileType       = 'exe'
  $silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  $validExitCodes = '0'

  $uninstallSoftwareName   = 'Subtitle Edit *'
  $uninstallFileType       = 'exe'
  $uninstallSilentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  $uninstallValidExitCodes = '0'

  $releasesUrl = 'https://api.github.com/repos/SubtitleEdit/subtitleedit/releases/latest'
  $releases = (Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing).Content | ConvertFrom-Json
  $version = $releases.tag_name -Match '^(?<version>.+)$'
  if (!$version) { throw 'Version not found.' }
  $version = $Matches['version']

  $urls = @($releases.assets | ? name -Like "*-Setup.zip")
  if ($urls.Length -ne 1) { throw 'Url not found.' }
  $url = $urls[0].browser_download_url
  $file = [IO.Path]::ChangeExtension($urls[0].name, $fileType)

  return @{
    Version                 = $version
    FileType                = $fileType
    Url32                   = $url
    File32                  = $file
    SilentArgs              = $silentArgs
    ValidExitCodes          = $validExitCodes
    UninstallSoftwareName   = $uninstallSoftwareName
    UninstallFileType       = $uninstallFileType
    UninstallSilentArgs     = $uninstallSilentArgs
    UninstallValidExitCodes = $uninstallValidExitCodes
  }
}

function global:au_SearchReplace {
  @{
    'tools\chocolateyInstall.ps1' = @{
      "^(\s*packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
      "^(\s*fileType\s*=\s*)'.*'$"          = "`$1'$($Latest.FileType)'"
      "^(\s*url\s*=\s*)'.*'$"               = "`$1'$($Latest.Url32)'"
      "^(\s*file\s*=\s*).*$"                = "`$1Join-Path `$toolsDir '$($Latest.File32)'"
      "^(\s*silentArgs\s*=\s*)'.*'$"        = "`$1'$($Latest.SilentArgs)'"
      "^(\s*checksum\s*=\s*)'.*'$"          = "`$1'$($Latest.Checksum32)'"
      "^(\s*checksumType\s*=\s*)'.*'$"      = "`$1'$($Latest.ChecksumType32)'"
      "^(\s*validExitCodes\s*=\s*)@\(.*\)$" = "`$1@($($Latest.ValidExitCodes))"
    }
    'tools\chocolateyUninstall.ps1' = @{
      "^([$]packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
      "^([$]softwareName\s*=\s*)'.*'$"      = "`$1'$($Latest.UninstallSoftwareName)'"
      "^([$]fileType\s*=\s*)'.*'$"          = "`$1'$($Latest.UninstallFileType)'"
      "^([$]silentArgs\s*=\s*)'.*'$"        = "`$1'$($Latest.UninstallSilentArgs)'"
      "^([$]validExitCodes\s*=\s*)@\(.*\)$" = "`$1@($($Latest.UninstallValidExitCodes))"
    }
  }
}

Update-Package -ChecksumFor 32 -Force:$Force
