$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'airserver'
  fileType       = 'msi'
  url            = 'http://dl.airserver.com/pc32/AirServer-5.1.2-x86.msi'
  url64bit       = 'http://dl.airserver.com/pc32/AirServer-5.1.2-x64.msi'
  silentArgs     = '/qn /norestart'
  checksum       = '87eda7f1cb178eb2ac08c91a60d0b4c84be6fa5c3194172c3ac00a5f8bf42497'
  checksumType   = 'sha256'
  checksum64     = 'dd2fc9d4dd674456107f8bb7d30bea9a34e1fc830f768de24bb7556a14b2ad5b'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
