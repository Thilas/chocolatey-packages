$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-18.3-Leia-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-18.3-Leia-x64.exe'
    silentArgs     = '/S'
    checksum       = '9b7e1a90d1ab2f2d69dc730cac8cdb3ca6f80736ae824ef74b6a210d666acbac'
    checksumType   = 'sha256'
    checksum64     = '0252a0ccb6d2aaa3771062889c2d76120c84a011541fc6c853911c29286afb1f'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
