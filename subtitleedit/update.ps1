[CmdletBinding()]
param([switch] $Force)

. (Join-Path $PSScriptRoot '..\Common.ps1')

function global:au_GetLatest {
  $latest = Get-GitHubLatest -Repository 'SubtitleEdit/subtitleedit' `
                             -FileType 'zip' `
                             -IsUrl32 { param($Url) $Url -like '*Setup*' } `
                             -Latest @{
                               FileType                = 'exe'
                               SilentArgs              = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
                               ValidExitCodes          = '0'
                               UninstallSoftwareName   = 'Subtitle Edit *'
                               UninstallFileType       = 'exe'
                               UninstallSilentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
                               UninstallValidExitCodes = '0'
                             }
  $file = [uri]::new($latest.Url32).Segments | select -Last 1
  Write-Verbose ("File: {0}" -f $file)
  $latest += @{ File32 = [System.IO.Path]::ChangeExtension($file, $latest.FileType) }
  Write-Verbose ("File32: {0}" -f $latest.File32)
  return $latest
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
