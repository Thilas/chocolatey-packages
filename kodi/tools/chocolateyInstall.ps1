$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'kodi'
  fileType       = 'exe'
  url            = 'http://mirrors.kodi.tv/releases/win32/kodi-17.3-Krypton.exe'
  url64bit       = 'http://mirrors.kodi.tv/releases/win32/kodi-17.3-Krypton.exe'
  silentArgs     = '/S'
  checksum       = '871a8c431515e68d62090022c55fe9cb2f95e65804a7ccff51929b1a7e6be890'
  checksumType   = 'sha256'
  checksum64     = '871a8c431515e68d62090022c55fe9cb2f95e65804a7ccff51929b1a7e6be890'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
