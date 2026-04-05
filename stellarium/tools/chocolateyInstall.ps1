$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    # url            = ''
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v26.1/stellarium-26.1-qt6-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    # checksum       = ''
    # checksumType   = ''
    checksum64     = 'f48d9ccc850e4143da4f8442c14b328c111294f6fcd4f1bf6a0a81801849c48b'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
