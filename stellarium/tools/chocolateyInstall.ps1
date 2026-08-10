$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    # url            = ''
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v26.2/stellarium-26.2-qt6-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    # checksum       = ''
    # checksumType   = ''
    checksum64     = 'cda1d07081c94781e388f6c607da5b85a3215a366ae545473ce92a7d38135045'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
