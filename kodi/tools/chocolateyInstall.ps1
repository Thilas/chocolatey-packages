$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-20.4-Nexus-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-20.4-Nexus-x64.exe'
    silentArgs     = '/S'
    checksum       = '74fc0e01b299a1f239f47d8ef95c3d1098788fcb3b00dffec9bd3b5437d5aace'
    checksumType   = 'sha256'
    checksum64     = '408f6808564239153af9b5fa50e8ad82114e6a9905b7e58957a4cb18b296913c'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
