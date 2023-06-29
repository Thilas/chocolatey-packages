$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-20.2-Nexus-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-20.2-Nexus-x64.exe'
    silentArgs     = '/S'
    checksum       = '696ef2d1adafd70cb5b7ab2a4692d33e73f914bcb595411afa21158c83659e22'
    checksumType   = 'sha256'
    checksum64     = 'e52b3d25e8577a8c83f8a90b573edb4f4f5e402013acbbeed0457cfa5401bc0c'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
