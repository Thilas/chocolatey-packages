$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-18.2-Leia_rc1-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-18.2-Leia_rc1-x64.exe'
    silentArgs     = '/S'
    checksum       = 'b80623f2fc06b7fd92c3c8c077777c015c71f447e9a254db62124d6b885e2286'
    checksumType   = 'sha256'
    checksum64     = 'fc051d2b7f15c858166df9611c6504bdb5f3eebaf4506d00ebcefde9970198b3'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
