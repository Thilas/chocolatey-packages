$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-22.0-Piers_beta2-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-22.0-Piers_beta2-x64.exe'
    silentArgs     = '/S'
    checksum       = 'fa73e983490b5180b721cf0388cc6ef6493592a712d899b6db976e97c1d07e11'
    checksumType   = 'sha256'
    checksum64     = '583c3e3a55bf1c63ce8e4432bd2e247d43a2aa319f0f72cd8acd02bf76adf8be'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
