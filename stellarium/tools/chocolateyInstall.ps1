$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v0.20.2/stellarium-0.20.2-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v0.20.2/stellarium-0.20.2-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '687d9fc4ab2b5a8f4fc32fe51d8ab1dce1ec6a7ff654f97760a96cd2e367feed'
    checksumType   = 'sha256'
    checksum64     = '6ab249b1ffe094f0ddfb3102a53f16f389d7fe7cd6756e47210e898b5a7863e2'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
