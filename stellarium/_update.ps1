param([switch] $Force)

Import-Module au

function ToHttps([string] $url) {
  if (![String]::IsNullOrEmpty($url) -and $url.StartsWith('http://')) { $url = $url.Insert(4, 's') }
  $url
}

function global:au_GetLatest {
  $releasesUrl    = 'http://www.stellarium.org/'
  $fileType       = 'exe'
  $silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  $validExitCodes = '0'

  $uninstallRegistryKeyName = 'Stellarium_is1'
  $uninstallFileType        = 'exe'
  $uninstallSilentArgs      = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  $uninstallValidExitCodes  = '0'

  $releases = Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing
  $version = $releases.Content -Match '>latest version is ([^<]+)<'
  if (!$version) { Throw [System.InvalidOperationException]'Version invalid.' }
  $version = $Matches[1]

  $paths = @($releases.Links | Where-Object href -Like "*$version*.$fileType*")
  if ($paths.Length -ne 2) { Throw [System.InvalidOperationException]'Url not found.' }
  $url32 = ToHttps($paths[0].href)
  $url64 = ToHttps($paths[1].href)

  return @{ Version = $version; Url32 = $url32; Url64 = $url64; FileType = $fileType; SilentArgs = $silentArgs; ValidExitCodes = $validExitCodes; UninstallRegistryKeyName = $uninstallRegistryKeyName; UninstallFileType = $uninstallFileType; UninstallSilentArgs = $uninstallSilentArgs; UninstallValidExitCodes = $uninstallValidExitCodes }
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
    'tools\chocolateyUninstall.ps1' = @{
      "^([$]packageName\s*=\s*)'.*'$"                = "`$1'$($Latest.PackageName)'"
      "^([$]uninstallRegistryKeyName\s*=\s*)'.*'$"   = "`$1'$($Latest.UninstallRegistryKeyName)'"
      "^([$]uninstallFileType\s*=\s*)'.*'$"          = "`$1'$($Latest.UninstallFileType)'"
      "^([$]uninstallSilentArgs\s*=\s*)'.*'$"        = "`$1'$($Latest.UninstallSilentArgs)'"
      "^([$]uninstallValidExitCodes\s*=\s*)@\(.*\)$" = "`$1@($($Latest.UninstallValidExitCodes))"
    }
  }
}

Update-Package -ChecksumFor all -Force:$Force
