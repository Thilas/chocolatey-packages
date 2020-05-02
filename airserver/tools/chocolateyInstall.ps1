$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'airserver'
    url            = 'https://dl.airserver.com/pc32/AirServer-5.5.11-x86-msi.zip'
    url64bit       = 'https://dl.airserver.com/pc32/AirServer-5.5.11-x64-msi.zip'
    unzipLocation  = $toolsDir
    checksum       = '7696ccc3df46d284a0a6783f3595f4b1775ac1c161f78deaa742d551badbed0e'
    checksumType   = 'sha256'
    checksum64     = '9b66dac58ab70d8982298cc759fc2552024ee45cfaa23de8888c35f66f58304a'
    checksumType64 = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'airserver'
    softwareName   = 'AirServer *'
    fileType       = 'msi'
    file           = "$toolsDir\AirServer-5.5.11-x86.msi"
    file64         = "$toolsDir\AirServer-5.5.11-x64.msi"
    silentArgs     = '/qn /norestart'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyInstallPackage @packageArgs

$file = $packageArgs.file
Remove-Item $file, "$file.ignore" -Force -ErrorAction SilentlyContinue
