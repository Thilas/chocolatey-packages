$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'airserver'
  fileType       = 'msi'
  url            = 'http://dl.airserver.com/pc32/AirServer-5.4.4-x86.msi'
  url64bit       = 'http://dl.airserver.com/pc32/AirServer-5.4.4-x64.msi'
  silentArgs     = '/qn /norestart'
  checksum       = '8c7b90c55db6c914b459dca535ed376412e8c9c9fea2da062dcb17e320b984a7'
  checksumType   = 'sha256'
  checksum64     = 'd4aced8afd2d38c0f3d85f84facace0a9e577d997b4c1e97ec77c7a2d1d661e7'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
