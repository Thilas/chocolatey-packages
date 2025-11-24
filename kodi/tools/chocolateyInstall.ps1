$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-21.3-Omega-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-21.3-Omega-x64.exe'
    silentArgs     = '/S'
    checksum       = 'f800ac31237cab33e4a5bf0382e049eccb3492e634f63994206f5b2a7f6980aa'
    checksumType   = 'sha256'
    checksum64     = '2c46c2bd60b38bb60eb0a5e3468bfd43e9235521eae2910b8c81455e46335c5c'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
