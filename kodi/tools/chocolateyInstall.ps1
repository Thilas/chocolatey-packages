$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-21.0-Omega_beta3-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-21.0-Omega_beta3-x64.exe'
    silentArgs     = '/S'
    checksum       = '3301c4c495861bb915753c921e9e350f660507ac4fb488b20685f4d208624220'
    checksumType   = 'sha256'
    checksum64     = '1ef4ff3a4f3495833870ac67f52e1720da2fa8c894ce1b65097476f7d094542e'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
