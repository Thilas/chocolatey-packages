$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v0.18.2/stellarium-0.18.2-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v0.18.2/stellarium-0.18.2-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '073ac98852c4dcc6a11eab3100ecbf5f36693b93e07fe519aaf65ab6f7ca84cb'
    checksumType   = 'sha256'
    checksum64     = 'e9cc23a04edb9efceee0095cc87dcf8476de8730c224b799f5b3fbffcff84f44'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
