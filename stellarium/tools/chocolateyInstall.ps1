$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v23.4/stellarium-23.4-qt5-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v23.4/stellarium-23.4-qt6-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = 'f7ac6b28070a8dc7e9b319cabc0cbdfb573aa502a0d6a3c59ad3c6ac148f4675'
    checksumType   = 'sha256'
    checksum64     = '21cae322ce6a358de95bc42e157ee32ebfad835266445a1b93742987104ded27'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
