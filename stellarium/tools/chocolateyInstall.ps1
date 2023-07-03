$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v23.2/stellarium-23.2-qt5-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v23.2/stellarium-23.2-qt6-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = 'c210f125f4a40093f434327df4c27d9fef7b9366747c6f6c48e88c0fabc86917'
    checksumType   = 'sha256'
    checksum64     = 'faf7913c9ff87d5844d2fbe61f97f56da8161b4e2d6932fadc52d0da318222a2'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
