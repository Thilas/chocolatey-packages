$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v0.20.3/stellarium-0.20.3-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v0.20.3/stellarium-0.20.3-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '238d41dddb635a3af587f443b082f3a0156cfba298d91a3073c85fe776b92d50'
    checksumType   = 'sha256'
    checksum64     = '4ac5ad74591b294cae6082aa253636ce5215e2e855ddec23526518b772f76176'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
