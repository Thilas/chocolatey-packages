$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v0.22.2/stellarium-0.22.2-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v0.22.2/stellarium-0.22.2-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '283f54c87bbf15f80cdfe86ba48be7e6a179b4575fde21133864fa23b679ea87'
    checksumType   = 'sha256'
    checksum64     = '1e14810e7d4eb90e60b842cadb32cb26a9e67ced75aa987bddb2c3bb280b3084'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
