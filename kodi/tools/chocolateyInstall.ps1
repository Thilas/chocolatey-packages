$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-20.0-Nexus-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-20.0-Nexus-x64.exe'
    silentArgs     = '/S'
    checksum       = '3889e1169b92c7a7dfca0969d8d114ee6764ca9d2bfec7455d400708000a7794'
    checksumType   = 'sha256'
    checksum64     = '642b4bcfaa413424bd86d4367a05cf9c130f93beac30b7d4342feabb5316a69f'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
