$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v23.3/stellarium-23.3-qt5-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v23.3/stellarium-23.3-qt6-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '59c88820028c36106852d4d5ee223fb8e27855a2b5dad97440423d7084fc8341'
    checksumType   = 'sha256'
    checksum64     = 'd89bb44594c3470da9df0aed2f2ede730a6fd5650e56bbabe2bf544e3f598697'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
