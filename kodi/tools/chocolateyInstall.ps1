$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-19.0-Matrix_beta1-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-19.0-Matrix_beta1-x64.exe'
    silentArgs     = '/S'
    checksum       = 'd55edc7f9518d2c4cf2ebcf1d1726ec55552092f191befd89fb9ef0ecc678f75'
    checksumType   = 'sha256'
    checksum64     = 'fcd84aa29ccff8b76309494bb9aaeb134a5e8b2b36be64384d68c4af08b57a8b'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
