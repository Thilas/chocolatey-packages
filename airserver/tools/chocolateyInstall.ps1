$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'airserver'
    softwareName   = 'AirServer *'
    fileType       = 'msi'
    url            = 'http://dl.airserver.com/pc32/AirServer-5.5.11-x86.msi'
    url64bit       = 'http://dl.airserver.com/pc32/AirServer-5.5.11-x64.msi'
    silentArgs     = '/qn /norestart'
    checksum       = '057eb5cd73b9704567c29840e6644e924251601a55e750de2c9a3a1a8c5349e0'
    checksumType   = 'sha256'
    checksum64     = 'c8c811762ef9550637ac840beb2e27a184c253e77d1360be08a9a3ba84362e9a'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
