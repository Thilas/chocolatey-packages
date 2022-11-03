$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v1.1/stellarium-1.1.1-qt5-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v1.1/stellarium-1.1.1-qt6-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '969ef09a80bd37411e73dbc1c6e5412f36e452243e5ce653d6000a226fef99f2'
    checksumType   = 'sha256'
    checksum64     = '88b0daedc43b01f071b97893a359f33287363bd1a1eabdc32d7cfd2ccf56e8b4'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
