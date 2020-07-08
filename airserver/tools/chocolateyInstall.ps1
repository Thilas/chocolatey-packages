$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'airserver'
    url            = 'http://dl.airserver.com/pc32/AirServer-5.6.0-x86.msi'
    url64bit       = 'http://dl.airserver.com/pc32/AirServer-5.6.0-x64.msi'
    unzipLocation  = $toolsDir
    checksum       = 'f46cffde2ceea25961e95ad6f6a4c5c6a2a2de5da954b64ad5fec7272cd40c60'
    checksumType   = 'sha256'
    checksum64     = 'b02d693ac1e3cbc9247ab212331c347b5c5c96f1f9c0a6fbae57c45d0b46c0f4'
    checksumType64 = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'airserver'
    softwareName   = 'AirServer *'
    fileType       = 'msi'
    file           = "$toolsDir\AirServer-5.6.0-x86.msi"
    file64         = "$toolsDir\AirServer-5.6.0-x64.msi"
    silentArgs     = '/qn /norestart'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyInstallPackage @packageArgs

$file = $packageArgs.file
Remove-Item $file, "$file.ignore" -Force -ErrorAction SilentlyContinue
