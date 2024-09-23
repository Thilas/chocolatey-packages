$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v24.3/stellarium-24.3-qt5-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v24.3/stellarium-24.3-qt6-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = 'f2f1ac3b1509596209266bc69056b2738849308ea81a304e8887e0159c43b4ee'
    checksumType   = 'sha256'
    checksum64     = 'd137912a94c1f2c3f25b0b36f20e2e7d3610b337b854bcd82bb66dba61e38a01'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
