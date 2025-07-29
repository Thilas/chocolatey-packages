$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'airserver'
    softwareName   = 'AirServer *'
    fileType       = 'msi'
    url            = 'https://dl.airserver.com/pc32/AirServer-5.7.2-x86.msi'
    url64bit       = 'https://dl.airserver.com/pc32/AirServer-5.7.2-x64.msi'
    silentArgs     = '/qn /norestart'
    checksum       = '6a0990ca4c8b637479233ca149714aff9ebe3fa5487133a499ca9a5fb04799d5'
    checksumType   = 'sha256'
    checksum64     = '173685e9c546993d9956030587ee296b61947e8944878538abd5a598b91a9bfc'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
