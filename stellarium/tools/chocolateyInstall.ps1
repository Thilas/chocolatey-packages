$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v0.19.0/stellarium-0.19.0-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v0.19.0/stellarium-0.19.0-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '9dd555c96e0637030ea9e9566af647608d5d3b5560144d8e6b30172efe2a3bfb'
    checksumType   = 'sha256'
    checksum64     = 'a8378ccf71176300f52776e7b90c3eb35742909352c502c0772a3deff88dc358'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
