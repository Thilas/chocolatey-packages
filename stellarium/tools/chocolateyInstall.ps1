$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v0.21.3/stellarium-0.21.3-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v0.21.3/stellarium-0.21.3-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '8467e2f7feffb22c100d6b18fc992aabc4885536d741f23d983174def31fca6d'
    checksumType   = 'sha256'
    checksum64     = '6d4279e4ec13368115fe0c0acb0b862f856b7b1d9560dc07f0791c44937873a6'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
