$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-18.1-Leia_rc1-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-18.1-Leia_rc1-x64.exe'
    silentArgs     = '/S'
    checksum       = 'd07303ef557df07c47052518d55aadd372db2052d5d4ab2930e1ed2410a7dbb6'
    checksumType   = 'sha256'
    checksum64     = 'fada1e9e3a63e5a6b971c61362e1fc03ea069302d8c73f5317e022fadc3a79e0'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
