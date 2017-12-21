$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'stellarium'
  fileType       = 'exe'
  url            = 'https://github.com/Stellarium/stellarium/releases/download/v0.17.0/stellarium-0.17.0-win32.exe'
  url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v0.17.0/stellarium-0.17.0-win64.exe'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  checksum       = '03469475fb36e7c742727ab262b3deee89e36ab516558ac5b1815154dc0f7552'
  checksumType   = 'sha256'
  checksum64     = 'c5eaf50409e23c3d6235ecc93fa674050d06b9492a21e64c8500dfc2335ab9bb'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
