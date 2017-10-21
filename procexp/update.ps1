[CmdletBinding()]
param([switch] $Force)

. (Join-Path $PSScriptRoot '..\Common.ps1')

function global:au_GetLatest {
  return Get-BasicLatest -ReleaseUrl 'https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer' `
                         -TagNamePattern '>Process Explorer v(?<tagName>[^<]+)<' `
                         -SkipTagName `
                         -FileType 'zip' `
                         -Latest @{ ValidExitCodes = '0' }
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
