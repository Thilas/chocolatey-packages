$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = ''
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v0.18.3/stellarium-0.18.3-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v0.18.3/stellarium-0.18.3-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '9aac73d529aed2a439b57a4f65400029a63764aca67913ee29a50df4c0720d0a'
    checksumType   = 'sha256'
    checksum64     = 'c4da3b3d3e07cd5b22648f6cee3adbca45ab7d84fd58d09e49344326951055e5'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
