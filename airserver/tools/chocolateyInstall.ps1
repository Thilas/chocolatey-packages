$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'airserver'
  fileType       = 'msi'
  url            = 'http://dl.airserver.com/pc32/AirServer-5.4.6-x86.msi'
  url64bit       = 'http://dl.airserver.com/pc32/AirServer-5.4.6-x64.msi'
  silentArgs     = '/qn /norestart'
  checksum       = 'a9da66ba3a0315dcf57ecb5d3c09a1ab7adfbfebe8a8e0f1ddd1704f9dcb637b'
  checksumType   = 'sha256'
  checksum64     = 'baacf924f4376833e0d4d8a6ef857c3fae38d2daaf14f86aec9d439448927728'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
