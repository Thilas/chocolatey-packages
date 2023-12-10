$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-21.0-Omega_beta2-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-21.0-Omega_beta2-x64.exe'
    silentArgs     = '/S'
    checksum       = '6adc4fdd221281d14167a16d3587485e705c8c7c2c493567cf08839217c5d7a0'
    checksumType   = 'sha256'
    checksum64     = '6937ea333cceadac1ccc6007a6273030b7f3f9592d0cc8150fdd1b9a473447b7'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
