$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'airserver'
    softwareName   = 'AirServer *'
    fileType       = 'msi'
    url            = 'http://dl.airserver.com/pc32/AirServer-5.5.6-x86.msi'
    url64bit       = 'http://dl.airserver.com/pc32/AirServer-5.5.6-x64.msi'
    silentArgs     = '/qn /norestart'
    checksum       = '6412141f10d8d6fb4a3bef816f120675bc15669f81ca5896f9ca10c12986724a'
    checksumType   = 'sha256'
    checksum64     = '8e026ebf42a18295355c256e186b5268d750300cf30455624d02ccddfba103c7'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
