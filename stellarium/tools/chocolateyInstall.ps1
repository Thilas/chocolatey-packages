$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v0.21.1/stellarium-0.21.1-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v0.21.1/stellarium-0.21.1-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = 'fa8883e1f7d8b25367bba133abcad6364277dfddc0d5b4c5b778d767e1ae448e'
    checksumType   = 'sha256'
    checksum64     = 'd260524e666d2219c8c50f302ba2a0227c6d0a52d552ebeb590d241981d8696d'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
