$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'airserver'
  fileType       = 'msi'
  url            = 'http://dl.airserver.com/pc32/AirServer-5.4.9-x86.msi'
  url64bit       = 'http://dl.airserver.com/pc32/AirServer-5.4.9-x64.msi'
  silentArgs     = '/qn /norestart'
  checksum       = '0dad54ea2d7024041747ba2968e292def63a42d59c6eb6f0299020fae60e60b8'
  checksumType   = 'sha256'
  checksum64     = '6aec13a2828945be1314b936f8a88a419c9ad031193dc378fa158c194dee5a3f'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
