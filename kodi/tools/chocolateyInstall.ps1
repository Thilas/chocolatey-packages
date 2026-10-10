$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-22.0-Piers_rc1-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-22.0-Piers_rc1-x64.exe'
    silentArgs     = '/S'
    checksum       = '39cac243a48b6ee73fc635ece5cd5c613c52e0a1e5da55633cc447a2ce98910a'
    checksumType   = 'sha256'
    checksum64     = '0d5e732aadbffa9e0ef38e368207326076d34b0759b6c14f080773db99ee83b1'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
