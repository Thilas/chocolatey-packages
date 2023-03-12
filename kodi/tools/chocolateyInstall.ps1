$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-20.1-Nexus-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-20.1-Nexus-x64.exe'
    silentArgs     = '/S'
    checksum       = 'bb0f6d2bff2b195fad9d76eb10e4f0ffa1dbdfda3f6100b98b76fc9a869d8724'
    checksumType   = 'sha256'
    checksum64     = 'e6973858cf711cf354b4b07e9df739326b60337bb91b3b7e6da0acadd0158d85'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
