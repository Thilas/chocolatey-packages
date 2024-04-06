$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-21.0-Omega-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-21.0-Omega-x64.exe'
    silentArgs     = '/S'
    checksum       = '3a50d0d112c36920693c082d7a7f8c6965c1e10f4e2a0f40ef5771d28629c8dc'
    checksumType   = 'sha256'
    checksum64     = '62768c33e149969d20bcc9e4df235e9896611d4fa1e96c5912ccc5f1d3cc34f5'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
