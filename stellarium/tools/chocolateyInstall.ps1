$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v0.18.0/stellarium-0.18.0-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v0.18.0/stellarium-0.18.0-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '5e026accee6180563580d6eac00797f4a1dbf809f7c6a6d08426a8e3741bba4d'
    checksumType   = 'sha256'
    checksum64     = '8a6fca69204a566c42ca3d23d2f2b3c7610cb6ecd8f8af52cc051a539afb3c1c'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
