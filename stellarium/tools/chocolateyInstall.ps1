$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    # url            = ''
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v26.3/stellarium-26.3-qt6-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    # checksum       = ''
    # checksumType   = ''
    checksum64     = '06d0444e02bca3ad9703e08a641270576c1df581088eb3e7549870887e039cd8'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
