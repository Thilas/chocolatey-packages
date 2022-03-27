$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v0.22.0/stellarium-0.22.0-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v0.22.0/stellarium-0.22.0-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '33deaf2e0d27c977b48c816326482583431eef3d24172012ce52f325334e45b9'
    checksumType   = 'sha256'
    checksum64     = '4f29c947940dfb9953f2386c3bfb4b0e91114223c969eba9447187896fe40e9f'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
