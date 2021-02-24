$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-19.0-Matrix-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-19.0-Matrix-x64.exe'
    silentArgs     = '/S'
    checksum       = 'fb789ce1dea294468e4b7dbb2344222e74fd676f8016d9a3046d11ac9352e11e'
    checksumType   = 'sha256'
    checksum64     = '387cbfd00ebe64ec9ebd02ea1f7271fdec9ef7fde75843501623b8e4348969a6'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
