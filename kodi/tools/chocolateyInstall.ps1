$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-19.0-Matrix_beta2-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-19.0-Matrix_beta2-x64.exe'
    silentArgs     = '/S'
    checksum       = 'fb5198ad577a51f4c855b73f22df440fd13f2d9bb6cdab26a369a53c00c164f0'
    checksumType   = 'sha256'
    checksum64     = '5606a928350f779e207e4cc18ef2c981734e6a186292b382b700b687684b1b96'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
