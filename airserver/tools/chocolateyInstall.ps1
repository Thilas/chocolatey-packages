$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'airserver'
    softwareName   = 'AirServer *'
    fileType       = 'msi'
    url            = 'http://dl.airserver.com/pc32/AirServer-5.5.5-x86.msi'
    url64bit       = 'http://dl.airserver.com/pc32/AirServer-5.5.5-x64.msi'
    silentArgs     = '/qn /norestart'
    checksum       = '446e60d6a7944eda7aa2a978e79a503eadc692d4474cc1b16f81dbcef35ae2e9'
    checksumType   = 'sha256'
    checksum64     = 'b05a4e3ec92f5b6ca1ae49dc99750d6ed50101c2daf463968a5706469b345e68'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
