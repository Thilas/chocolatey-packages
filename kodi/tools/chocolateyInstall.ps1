$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    fileType       = 'exe'
    url            = 'http://mirrors.kodi.tv/releases/windows/win32/kodi-17.6-Krypton-x86.exe'
    url64bit       = 'http://mirrors.kodi.tv/releases/windows/win32/kodi-17.6-Krypton-x86.exe'
    silentArgs     = '/S'
    checksum       = '6f4ae208ea5e8cd57df5c034b17a2f5e294b3f59b273987762cd8bed805afb0a'
    checksumType   = 'sha256'
    checksum64     = '6f4ae208ea5e8cd57df5c034b17a2f5e294b3f59b273987762cd8bed805afb0a'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
