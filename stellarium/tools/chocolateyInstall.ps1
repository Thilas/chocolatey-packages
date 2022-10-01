$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v1.0/stellarium-0.22.3-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v1.0/stellarium-1.22.3-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '23568ac56d63d0d72aa6bfc5bb89eb407b3ebb1b8e451781e37ade78422a470f'
    checksumType   = 'sha256'
    checksum64     = 'f26a6a0b046877180ae0826e8095652d76d27ae369c5d0372ed001346034d459'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
