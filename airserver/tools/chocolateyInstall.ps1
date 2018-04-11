$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'airserver'
    fileType       = 'msi'
    url            = 'http://dl.airserver.com/pc32/AirServer-5.5.3-x86.msi'
    url64bit       = 'http://dl.airserver.com/pc32/AirServer-5.5.3-x64.msi'
    silentArgs     = '/qn /norestart'
    checksum       = 'e8634c21ea4cebee73dd023f32170f49d5f063676609be72ce6a7d3ca5c5f09c'
    checksumType   = 'sha256'
    checksum64     = 'b7b5ce23c13affe8907993ff65f108d1bc1393566f7122e4f7b36ce176201088'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
