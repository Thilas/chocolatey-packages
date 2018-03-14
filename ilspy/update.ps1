[CmdletBinding()]
param([switch] $Force)

. (Join-Path $PSScriptRoot '..\Common.ps1')

function global:au_GetLatest {
  return Get-GitHubLatest -Repository 'icsharpcode/ILSpy' `
                          -SkipTagName `
                          -FileType 'zip' `
                          -IsUrl32 { param($Url, $TagName, $Version) $Url -like '*binaries*' }
}

function global:au_SearchReplace {
  @{
    'tools\chocolateyInstall.ps1' = @{
      "^(\s*packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
      "^(\s*url\s*=\s*)'.*'$"               = "`$1'$($Latest.Url32)'"
      "^(\s*checksum\s*=\s*)'.*'$"          = "`$1'$($Latest.Checksum32)'"
      "^(\s*checksumType\s*=\s*)'.*'$"      = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

Update-Package -ChecksumFor 32 -Force:$Force
