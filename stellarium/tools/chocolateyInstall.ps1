$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'stellarium'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/stellarium/files/Stellarium-win32/0.16.0/stellarium-0.16.0-win32.exe/download'
  url64bit       = 'https://sourceforge.net/projects/stellarium/files/Stellarium-win64/0.16.0/stellarium-0.16.0-win64.exe/download'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  checksum       = '373fa59806fd06d82da1bbca373fa5a4df869f33eb077cba39afaf7e29152b16'
  checksumType   = 'sha256'
  checksum64     = 'bdf6017b6767552c12fef3b3f81a20d593254bdc2ffe41e075ac5647c32015e3'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
