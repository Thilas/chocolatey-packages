$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-21.0-Omega_rc1-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-21.0-Omega_rc1-x64.exe'
    silentArgs     = '/S'
    checksum       = '4643f6f7847d77bed95e6034612602e5cafbedf3f0b660b5ad9dda6f0913269d'
    checksumType   = 'sha256'
    checksum64     = '62501974411c14c6bd50dbc3796ec24a1909653e8e534e01aa0427333bc0fa4d'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
