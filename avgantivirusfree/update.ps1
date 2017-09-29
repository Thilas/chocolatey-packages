param([switch] $Force)

Import-Module au

function global:au_GetLatest {
  $fileType       = 'exe'
  $silentArgs     = '/mode=offline /install=fmw,zen,bav /langid=$((Get-UICulture).LCID) /silent=true'
  $validExitCodes = '0'

  $uninstallSoftwareName   = 'AVG Protection'
  $uninstallFileType       = 'exe'
  $uninstallSilentArgs     = '/mode=offline /uninstall=fmw,zen,bav /silent=true'
  $uninstallValidExitCodes = '0'

  $releasesUrl = 'http://www.avg.com/download.prd-gsr-free'
  $releases = Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing
  $urls = @($releases.Links | ? href -Like "*.$fileType" | ? href -NotLike '*x86*' | ? href -NotLike '*x64*')
  if ($urls.Length -ne 1) { throw 'Version not found (1).' }
  $version = $urls[0].href -Match "_(?<version>\d+)\.$fileType"
  if (!$version) { throw 'Version not found (2).' }
  $version = "$([System.DateTime]::UtcNow.Year % 100).0.$($Matches['version'])"

  $urls = @($releases.Links | ? href -Like "*.$fileType" | ? href -Like '*x86*')
  if ($urls.Length -ne 1) { throw 'Url (x86) not found.' }
  $url32 = $urls[0].href
  $urls = @($releases.Links | ? href -Like "*.$fileType" | ? href -Like '*x64*')
  if ($urls.Length -ne 1) { throw 'Url (x64) not found.' }
  $url64 = $urls[0].href

  return @{
    Version                 = $version
    FileType                = $fileType
    Url32                   = $url32
    Url64                   = $url64
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
      "^(\s*url64bit\s*=\s*)'.*'$"          = "`$1'$($Latest.Url64)'"
      "^(\s*silentArgs\s*=\s*)"".*""$"      = "`$1""$($Latest.SilentArgs)"""
      "^(\s*checksum\s*=\s*)'.*'$"          = "`$1'$($Latest.Checksum32)'"
      "^(\s*checksumType\s*=\s*)'.*'$"      = "`$1'$($Latest.ChecksumType32)'"
      "^(\s*checksum64\s*=\s*)'.*'$"        = "`$1'$($Latest.Checksum64)'"
      "^(\s*checksumType64\s*=\s*)'.*'$"    = "`$1'$($Latest.ChecksumType64)'"
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

Update-Package -ChecksumFor all -Force:$Force
