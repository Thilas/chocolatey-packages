$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-18.5-Leia-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-18.5-Leia-x64.exe'
    silentArgs     = '/S'
    checksum       = '2679c55961b86832a41281fa514b418adabb8df3fd09f47ef24daeff76bb992e'
    checksumType   = 'sha256'
    checksum64     = 'e8b982e21a2ee8f62a4bf20de2849154f0ac62e472ed4414f87ce59b4f16774b'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
