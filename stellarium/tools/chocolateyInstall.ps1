$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v24.4/stellarium-24.4-qt5-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v24.4/stellarium-24.4-qt6-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '71b620f40b330af0444791181684942df7b8bd51c73b72a32b3e2c3d0109a127'
    checksumType   = 'sha256'
    checksum64     = 'c52a7a2da4e0639457d1c4a2010d4bdbf47594710fac179fdfa69718d83bc36b'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
