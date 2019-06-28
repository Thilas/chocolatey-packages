$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'airserver'
    softwareName   = 'AirServer *'
    fileType       = 'msi'
    url            = 'http://dl.airserver.com/pc32/AirServer-5.5.7-x86.msi'
    url64bit       = 'http://dl.airserver.com/pc32/AirServer-5.5.7-x64.msi'
    silentArgs     = '/qn /norestart'
    checksum       = 'b0c3515721590a94fb5588e1ecee0daa65c1e4c88b3c2144cde36a621dc7dd67'
    checksumType   = 'sha256'
    checksum64     = '32ac65557ce4dad7baa09c47e1503a8a9d242c168f6301d27be3e426f4003bc1'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
