$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-19.5-Matrix-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-19.5-Matrix-x64.exe'
    silentArgs     = '/S'
    checksum       = 'c3026b5846371145a86054ee421bb3936394b0bad3cc45c2b9f11537f809f988'
    checksumType   = 'sha256'
    checksum64     = '5e2177703ab6b0ec8397ad209956a65898021352b983d2917862efe2b6556f4c'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
