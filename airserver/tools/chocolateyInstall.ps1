$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'airserver'
  fileType       = 'msi'
  url            = 'http://dl.airserver.com/pc32/AirServer-5.2.23-x86.msi'
  url64bit       = 'http://dl.airserver.com/pc32/AirServer-5.2.23-x64.msi'
  silentArgs     = '/qn /norestart'
  checksum       = 'fe3a1a36ae8abb9a4e9cb6f51b8272ec5cedafe27784f662e435acd2479a928c'
  checksumType   = 'sha256'
  checksum64     = '6ff40849aaa34072a4b8710caa76a85c7f9d524a5812b1ffbbff485959d318bb'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
