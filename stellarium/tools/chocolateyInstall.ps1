$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v0.20.1/stellarium-0.20.1-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v0.20.1/stellarium-0.20.1-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = 'a13b4a73ace386fc8eb4fbab9cacdc0c5043aa944e244bd56cca9da438e04f83'
    checksumType   = 'sha256'
    checksum64     = 'a06cd2ce8c34d791cbe7472d40c5520dd164bd790e5de30118b74e8ef718b934'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
