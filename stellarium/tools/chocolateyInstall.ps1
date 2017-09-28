$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'stellarium'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/stellarium/files/Stellarium-win32/0.16.1/stellarium-0.16.1-win32.exe/download'
  url64bit       = 'https://sourceforge.net/projects/stellarium/files/Stellarium-win64/0.16.1/stellarium-0.16.1-win64.exe/download'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  checksum       = '896027448d81b4b64d930960be1cdaca286f28995340b79b8e6739bd6a07d242'
  checksumType   = 'sha256'
  checksum64     = '32bcdca8a0ad8bc2a2b61ce908470d4e01c50994d8638f10d529aa65b5b38bc4'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
