$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'airserver'
    url            = 'http://dl.airserver.com/pc32/AirServer-5.6.2-x86.msi'
    url64bit       = 'http://dl.airserver.com/pc32/AirServer-5.6.2-x64.msi'
    unzipLocation  = $toolsDir
    checksum       = 'eb90539f2dfb4dd5e9e924f3a73ff3190ffd8f831622b1f06a380d024f570d52'
    checksumType   = 'sha256'
    checksum64     = '88e52799494eba8f8bf71f115df894d7b87d6cee68c47b0e964e33ae9894ad41'
    checksumType64 = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'airserver'
    softwareName   = 'AirServer *'
    fileType       = 'msi'
    file           = "$toolsDir\AirServer-5.6.2-x86.msi"
    file64         = "$toolsDir\AirServer-5.6.2-x64.msi"
    silentArgs     = '/qn /norestart'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyInstallPackage @packageArgs

$file = $packageArgs.file
Remove-Item $file, "$file.ignore" -Force -ErrorAction SilentlyContinue
