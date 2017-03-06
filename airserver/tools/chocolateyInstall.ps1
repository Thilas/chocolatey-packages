$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'airserver'
  fileType       = 'msi'
  url            = 'http://dl.airserver.com/pc32/AirServer-5.2.14-x86.msi'
  url64bit       = 'http://dl.airserver.com/pc32/AirServer-5.2.14-x64.msi'
  silentArgs     = '/qn /norestart'
  checksum       = '9d373d9ed4fbd27300e6c3c6608f2d84578aa243d5ede17da6fc8dd8ece11c47'
  checksumType   = 'sha256'
  checksum64     = '8d1577701bf68fee0c8eadfc9897a1271c6532941c4ea1d624303e83834010e7'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
