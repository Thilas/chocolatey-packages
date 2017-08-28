$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'kodi'
  fileType       = 'exe'
  url            = 'http://mirrors.kodi.tv/releases/windows/win32/kodi-17.4-Krypton-x86.exe'
  url64bit       = 'http://mirrors.kodi.tv/releases/windows/win32/kodi-17.4-Krypton-x86.exe'
  silentArgs     = '/S'
  checksum       = '940be9469a75a7f00f7e443a6de7c3d20dc5d485085f8117dc376b87dae52459'
  checksumType   = 'sha256'
  checksum64     = '940be9469a75a7f00f7e443a6de7c3d20dc5d485085f8117dc376b87dae52459'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
