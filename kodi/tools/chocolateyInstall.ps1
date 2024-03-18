$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-21.0-Omega_rc2-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-21.0-Omega_rc2-x64.exe'
    silentArgs     = '/S'
    checksum       = 'd98627e08723dfd4d0151c26b6a06f9c4b006642769a8d5eb6e2be617597cb76'
    checksumType   = 'sha256'
    checksum64     = '30447a2059e1f36b98248e53f55c1a6ac66e79bb73e9695caa05c68513ace667'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
