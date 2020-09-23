$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'airserver'
    softwareName   = 'AirServer *'
    fileType       = 'msi'
    url            = 'https://dl.airserver.com/pc32/AirServer-5.6.3-x86.msi'
    url64bit       = 'https://dl.airserver.com/pc32/AirServer-5.6.3-x64.msi'
    silentArgs     = '/qn /norestart'
    checksum       = '0790b32d7480ef3a429242e78ea699c74a406f2e80dee1c08b45f6616680ffe0'
    checksumType   = 'sha256'
    checksum64     = '4a92c6e42fb2bec9fb177f6d379b3e86728d81bfe3f69fc53c175c13532b586f'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
