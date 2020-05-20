$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-18.7-Leia-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-18.7-Leia-x64.exe'
    silentArgs     = '/S'
    checksum       = '2c193c5bc16eb001dad29310a5bae7a731c6766693c48b22616d611064014997'
    checksumType   = 'sha256'
    checksum64     = '7ed9c86d67b8849678d6b6a8d4f23ac3395151ce2bd88b71b78a2efd4bb48652'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
