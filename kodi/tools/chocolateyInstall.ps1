$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-18.0-Leia-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-18.0-Leia-x64.exe'
    silentArgs     = '/S'
    checksum       = 'd0be2fc7180f542202aa60a8f5475fa225d02079fd38d8dd2738770dec05a38e'
    checksumType   = 'sha256'
    checksum64     = 'cd7148037253376da80f5924f49652ba5fdc7dadd4586faa30d62e31db45ffc9'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
