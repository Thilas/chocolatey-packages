$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v0.19.1/stellarium-0.19.1.1-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v0.19.1/stellarium-0.19.1.1-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = 'de175e1c091b417b2e93beb29d573e234a2a08b59d819d18d3592f660c690bfa'
    checksumType   = 'sha256'
    checksum64     = '2de092d84961c7830b8c72c026780def4e573719eae4bb8a1ca4851bff89fca4'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
