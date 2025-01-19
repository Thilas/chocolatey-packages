$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-21.2-Omega-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-21.2-Omega-x64.exe'
    silentArgs     = '/S'
    checksum       = '37516550aefb1e416801cba6c1ea2cf559c72ec336c99ade3507330c75aeb13a'
    checksumType   = 'sha256'
    checksum64     = 'daac44fad06f4179f658f233bc777c47db24b3e9718b596b223aedc0f89de1b0'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
