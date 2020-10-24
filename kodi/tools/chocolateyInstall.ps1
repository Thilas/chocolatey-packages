$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-18.9-Leia-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-18.9-Leia-x64.exe'
    silentArgs     = '/S'
    checksum       = '4b9fc49c2211b9c26190d584808cd4f89bf7ff8f7f9f8084ce8c09d538969bc1'
    checksumType   = 'sha256'
    checksum64     = '1819c2bed5bf94b0491879c09e093a40eb358e8b0f5e024c54542d52a27fe78b'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
