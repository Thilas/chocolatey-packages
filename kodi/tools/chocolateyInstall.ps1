$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-18.2-Leia-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-18.2-Leia-x64.exe'
    silentArgs     = '/S'
    checksum       = '18ed2ec3ea5da4aeb0c3e8eeed9a0b41756e24ac4944b97b61ec4f984e24dcf2'
    checksumType   = 'sha256'
    checksum64     = 'afcafa72026f65af197f9014fd239e3c5929151a1e52c58fc4a6d288aa070e88'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
