$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-18.6-Leia-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-18.6-Leia-x64.exe'
    silentArgs     = '/S'
    checksum       = '6209a3c99dd05a35d323da4fae9c06e4da1e26bb50deb3b1c490ab1536cdb128'
    checksumType   = 'sha256'
    checksum64     = 'afa47e8fb3e5403ff522519cb2fb2378e988e837c4816f71f562da5d374ad257'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
