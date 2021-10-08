$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-19.2-Matrix-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-19.2-Matrix-x64.exe'
    silentArgs     = '/S'
    checksum       = '41c876cf6b21c8cc2504d506e50f8ca71ea5300c783e695cf57333b76ba21e90'
    checksumType   = 'sha256'
    checksum64     = 'bd4a1ec22a4239983cc7874dbb2e2db9d9c292ec8ce9e8619735630303ff4e0b'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
