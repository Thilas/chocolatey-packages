$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'stellarium'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/stellarium/files/Stellarium-win32/0.15.2/stellarium-0.15.2-win32.exe/download'
  url64bit       = 'https://sourceforge.net/projects/stellarium/files/Stellarium-win64/0.15.2/stellarium-0.15.2-win64.exe/download'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  checksum       = '2f8a4df1d80a862e6d7822c65bbf2556cc7dc9bd811108e3abab1e1cf609e121'
  checksumType   = 'sha256'
  checksum64     = '785b7f420872d177f40b70b565e757fc26a66871f3c75c957452ae2b1b6638a0'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
