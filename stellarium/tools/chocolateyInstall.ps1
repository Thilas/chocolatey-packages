$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v23.1/stellarium-23.1-qt5-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v23.1/stellarium-23.1-qt6-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '49d41ea0606e544fb4063edd11af0d82c68f77c41111116c69e2293d1be9d0bb'
    checksumType   = 'sha256'
    checksum64     = '24f17311aacd464ce6cc600f873f870d73dd5b68c4e5b84573e69b80a57278d9'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
