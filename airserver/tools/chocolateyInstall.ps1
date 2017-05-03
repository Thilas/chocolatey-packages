$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'airserver'
  fileType       = 'msi'
  url            = 'http://dl.airserver.com/pc32/AirServer-5.3.0-x86.msi'
  url64bit       = 'http://dl.airserver.com/pc32/AirServer-5.3.0-x64.msi'
  silentArgs     = '/qn /norestart'
  checksum       = 'caa753d7e1839b7397ad978cd2b4c764d22a0de2e193c9092af340d4a2871834'
  checksumType   = 'sha256'
  checksum64     = '1f77ee6899417f39264af9de9da2c12c0ce44da6e9908127ad84763afe5dfb3c'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
