$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-20.0-Nexus_beta1-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-20.0-Nexus_beta1-x64.exe'
    silentArgs     = '/S'
    checksum       = '7c8375f0601eb7dc9504456e04db0041a7271ae8ce9b66e27bb78e4bc69e8623'
    checksumType   = 'sha256'
    checksum64     = '9bc6aa0949100c8e3d4201c7f270231e55b20ba5595b2b4eac7a1997dcfbc426'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
