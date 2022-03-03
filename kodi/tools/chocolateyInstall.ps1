$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-19.4-Matrix-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-19.4-Matrix-x64.exe'
    silentArgs     = '/S'
    checksum       = '0df9b3d6a75b33af2dfe94addd926cab6eea10c2d04200e61b782944c36a5ad5'
    checksumType   = 'sha256'
    checksum64     = '9988067ed7c9bc64258fa9553dbb44d6619443ee10fd2127b2555da795eb2a69'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
