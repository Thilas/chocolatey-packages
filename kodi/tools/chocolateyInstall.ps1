$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'kodi'
  fileType       = 'exe'
  url            = 'http://mirrors.kodi.tv/releases/windows/win32/kodi-17.4-Krypton_rc1.exe'
  url64bit       = 'http://mirrors.kodi.tv/releases/windows/win32/kodi-17.4-Krypton_rc1.exe'
  silentArgs     = '/S'
  checksum       = '52d9bf767900ab07cba07b8a9fb00f8dc2b3850b1ef2f7e181df1f9714fb1844'
  checksumType   = 'sha256'
  checksum64     = '52d9bf767900ab07cba07b8a9fb00f8dc2b3850b1ef2f7e181df1f9714fb1844'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
