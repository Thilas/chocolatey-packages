$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-18.1-Leia-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-18.1-Leia-x64.exe'
    silentArgs     = '/S'
    checksum       = 'd3610f0aa119c2fce681f02055df7e0d1f9f21410adee4209cfe1c17a3a4b21c'
    checksumType   = 'sha256'
    checksum64     = '2a898e4cc5cc7db32474aba6800024bb5958596a29d9f6eb852dc5ac4e189a32'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
