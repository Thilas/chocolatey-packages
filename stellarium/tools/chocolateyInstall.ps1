$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v0.20.4/stellarium-0.20.4-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v0.20.4/stellarium-0.20.4-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = 'f7a903d5d17ec02358088ed2ce1b059604b6b2d548a2676d7f431c1c814f6dd5'
    checksumType   = 'sha256'
    checksum64     = '47d0ea1e1b72123cd07dac1f34f131847d30de649b1dc5ba27a4feca1b212870'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
