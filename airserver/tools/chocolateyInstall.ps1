$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'airserver'
    softwareName   = 'AirServer *'
    fileType       = 'msi'
    url            = 'https://dl.airserver.com/pc32/AirServer-5.7.0-x86.msi'
    url64bit       = 'https://dl.airserver.com/pc32/AirServer-5.7.0-x64.msi'
    silentArgs     = '/qn /norestart'
    checksum       = '309c105669bb592a0e0165c6e0bf56aca43c43938c8f798b46518e387aa5c262'
    checksumType   = 'sha256'
    checksum64     = '9f149559f90a88595d0a39e12da03f954075015a3e935c663aa3daf7da9ef98c'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
