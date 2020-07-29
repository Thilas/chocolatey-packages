$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'airserver'
    url            = 'http://dl.airserver.com/pc32/AirServer-5.6.1-x86.msi'
    url64bit       = 'http://dl.airserver.com/pc32/AirServer-5.6.1-x64.msi'
    unzipLocation  = $toolsDir
    checksum       = '56842660ef74c2985160e07b9b59cd1bd811011446587d0ffda7e64ef065425a'
    checksumType   = 'sha256'
    checksum64     = '9dcf47f2c7161f8192cde724e62e1a638adaeb2a03fbc8d1933d307f884e3d18'
    checksumType64 = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'airserver'
    softwareName   = 'AirServer *'
    fileType       = 'msi'
    file           = "$toolsDir\AirServer-5.6.1-x86.msi"
    file64         = "$toolsDir\AirServer-5.6.1-x64.msi"
    silentArgs     = '/qn /norestart'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyInstallPackage @packageArgs

$file = $packageArgs.file
Remove-Item $file, "$file.ignore" -Force -ErrorAction SilentlyContinue
