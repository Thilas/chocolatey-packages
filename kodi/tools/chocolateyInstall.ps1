$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-18.4-Leia-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-18.4-Leia-x64.exe'
    silentArgs     = '/S'
    checksum       = 'a83aac61d988cc5bed982f3e556655d334407ae37b85ce968e8569b75ba50d57'
    checksumType   = 'sha256'
    checksum64     = '963343668e7259a0a579dc93aba3e4143353e86f5eb56ca8e6326a7aa7a75ab8'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
