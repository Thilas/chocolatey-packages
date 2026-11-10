$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-22.0-Piers_rc2-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-22.0-Piers_rc2-x64.exe'
    silentArgs     = '/S'
    checksum       = '7407f627a4f650c85d7fe05f9b77ff4f11c5a5cffabd4a6296d2f9972ca1c61b'
    checksumType   = 'sha256'
    checksum64     = '2823db44e0b8ed9184f9acb26fddfb6e63875ce070ddf506e8b225ce0773ede6'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
