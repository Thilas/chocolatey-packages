$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-19.0-Matrix_rc1-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-19.0-Matrix_rc1-x64.exe'
    silentArgs     = '/S'
    checksum       = '2484b4e18dcbe40e71bc72ec0a7ea6bc2f92be2d0e80edebd6399b5df7575085'
    checksumType   = 'sha256'
    checksum64     = '0cde4f4ea6a6beae1a940b17295eca482dc7ee1f05c613afb162984794fbaedf'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
