$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-21.0-Omega_beta1-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-21.0-Omega_beta1-x64.exe'
    silentArgs     = '/S'
    checksum       = '50066ef6e6f807bdbadf11110f0ab6b04cb663e4ea37f293e2fb6d7111410996'
    checksumType   = 'sha256'
    checksum64     = '5c892e0b0dc8612c4cac0333b99b157b9139e2457d2a1e4ccdcaa505cdeeb43b'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
