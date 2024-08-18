$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-21.1-Omega-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-21.1-Omega-x64.exe'
    silentArgs     = '/S'
    checksum       = 'a0d24283bccd8706da2b401fdb2b2359b65337842360c760694ad4c6dd443723'
    checksumType   = 'sha256'
    checksum64     = '089519649fccf9fe0e5f9f6369521d035cd64553947a3bcea1acc7614e00a88f'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
