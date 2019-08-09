$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'airserver'
    softwareName   = 'AirServer *'
    fileType       = 'msi'
    url            = 'http://dl.airserver.com/pc32/AirServer-5.5.8-x86.msi'
    url64bit       = 'http://dl.airserver.com/pc32/AirServer-5.5.8-x64.msi'
    silentArgs     = '/qn /norestart'
    checksum       = 'b12fc391968089aa8d28a7c424dc5de9204b29def522c97b7fd0d1645ba61dbf'
    checksumType   = 'sha256'
    checksum64     = '8b0483c1fc8666b463353cd520ee732060ad4fc1412ff41ef7c913050ff4beb9'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
