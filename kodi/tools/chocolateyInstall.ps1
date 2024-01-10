$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-20.3-Nexus-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-20.3-Nexus-x64.exe'
    silentArgs     = '/S'
    checksum       = 'a76ed6f27299b2f60932e0e32443c444c83d73a3c5e5a0b5776d580a1541aed5'
    checksumType   = 'sha256'
    checksum64     = 'aca015a5fee6c4a02bc2ef11563d681459acd68cc1766935edbe570ca8c33bf7'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
