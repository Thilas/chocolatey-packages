$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-18.8-Leia-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-18.8-Leia-x64.exe'
    silentArgs     = '/S'
    checksum       = 'e8565a07ce8f1948bafd629460d73f17ea7791da488b24b7a935c6f19f2ab511'
    checksumType   = 'sha256'
    checksum64     = '4b19cc378e4ed0d3149b54d827ef767e6c1f4a51e08cc8e475578a70f6e4177a'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
