$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v0.22.1/stellarium-0.22.1-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v0.22.1/stellarium-0.22.1-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '720f340800370dbf03547211ce567c48f0f2aa552cf3e5dc98a095053a49377a'
    checksumType   = 'sha256'
    checksum64     = '769e647a6b977ae6b03bc6b9290552bc5ad6a9071b53a7fee7f5291b9229e396'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
