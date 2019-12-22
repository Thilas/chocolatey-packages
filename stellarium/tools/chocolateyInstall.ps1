$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v0.19.3/stellarium-0.19.3-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v0.19.3/stellarium-0.19.3-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '18ae9a38c25bf3473604c52f4a8797f0a69cf7e19c396bbabb17c028b22b4643'
    checksumType   = 'sha256'
    checksum64     = '9da59c8730cf80837d4c460e83e1a4c2438e7f7f9f98f1ed7df8617c8495a92b'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
