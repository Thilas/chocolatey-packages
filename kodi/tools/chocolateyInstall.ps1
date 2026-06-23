$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-22.0-Piers_beta1-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-22.0-Piers_beta1-x64.exe'
    silentArgs     = '/S'
    checksum       = '351a4c85c8e02f4034055d0d98e7662a19c9790cd7d19a87fa1658a5866c8519'
    checksumType   = 'sha256'
    checksum64     = '784a321db28d4a3176317b310c4df8601d195a187896266ea2f4b7567d10da8a'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
