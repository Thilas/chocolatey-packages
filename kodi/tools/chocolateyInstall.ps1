$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-18.3-Leia-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-18.3-Leia-x64.exe'
    silentArgs     = '/S'
    checksum       = '59d2da6ebea8bdc604897cbf136cc1f095de65d0da5a47ee74646d7b1bed8e8c'
    checksumType   = 'sha256'
    checksum64     = '5762a56193a684c86bcb38ca1c1fa88ff39c11a932a4be25a9685b5259175edd'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
