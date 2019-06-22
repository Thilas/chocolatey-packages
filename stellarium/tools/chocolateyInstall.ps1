$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v0.19.1/stellarium-0.19.1-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v0.19.1/stellarium-0.19.1-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = 'a1283b671d692b266a95a78cd2ec1ae034d9402b1c65f5635831abf009a6f52b'
    checksumType   = 'sha256'
    checksum64     = '8c31f21fad3838f13c6d602761d2b577afe7e301e2f7d15ab1823927db8bdf7e'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
