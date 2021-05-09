$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-19.1-Matrix-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-19.1-Matrix-x64.exe'
    silentArgs     = '/S'
    checksum       = '6cc57b3de9b0c6f51c20cc4edab5c0584928da1bc09f2740278e1ddb6fb48c63'
    checksumType   = 'sha256'
    checksum64     = 'ecbb43dad45d3442d3dec14c66429766f19ea86ac050ad86c2edd7e20313b4df'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
