$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-20.5-Nexus-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-20.5-Nexus-x64.exe'
    silentArgs     = '/S'
    checksum       = 'a1d8e6922c90b5756863c6c5362425110ae313f1d6b9cce5bf2e7c8dffd8f351'
    checksumType   = 'sha256'
    checksum64     = 'f5585bb12f5027eb86dcfac60a790faffd6ac7aa06cdc0d5c47b87ef0ee7a9ea'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
