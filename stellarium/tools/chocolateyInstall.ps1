$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v24.2/stellarium-24.2-qt5-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v24.2/stellarium-24.2-qt6-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '35ef9fe4c4217c5dd36d611b29382c5af61423edec9c7ef13c2b27ce6b80a5ad'
    checksumType   = 'sha256'
    checksum64     = '73b1e6e73a167260d5d95dd02556274cdb66f43ead2b00d02f35024adb436e32'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
