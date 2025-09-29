$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    # url            = ''
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v25.3/stellarium-25.3-qt6-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    # checksum       = ''
    # checksumType   = ''
    checksum64     = 'fd7ebd2f3bf1a068a9932fe61a087dbad84ba15d0bc6ccf015440f4a61d7f310'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
