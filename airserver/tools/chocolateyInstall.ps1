$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'airserver'
  fileType       = 'msi'
  url            = 'http://dl.airserver.com/pc32/AirServer-5.3.2-x86.msi'
  url64bit       = 'http://dl.airserver.com/pc32/AirServer-5.3.2-x64.msi'
  silentArgs     = '/qn /norestart'
  checksum       = '028d87e5e10b65488194870f89ab91788c428d3aa61dbecd96c98d75782c6654'
  checksumType   = 'sha256'
  checksum64     = 'afdae698ebd79e156891e70e53326cba8c76faac19aa563c6418a63dedff1fc0'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
