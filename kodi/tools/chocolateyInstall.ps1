$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'kodi'
  fileType       = 'exe'
  url            = 'http://mirrors.kodi.tv/releases/windows/win32/kodi-17.5-Krypton-x86.exe'
  url64bit       = 'http://mirrors.kodi.tv/releases/windows/win32/kodi-17.5-Krypton-x86.exe'
  silentArgs     = '/S'
  checksum       = '3bed2f5e0f7dce622a4775ed848e86a98b48e45f7c7b1bd7635bafe559ff1a1b'
  checksumType   = 'sha256'
  checksum64     = '3bed2f5e0f7dce622a4775ed848e86a98b48e45f7c7b1bd7635bafe559ff1a1b'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
