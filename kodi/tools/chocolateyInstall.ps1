$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-18.4-Leia-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-18.4-Leia-x64.exe'
    silentArgs     = '/S'
    checksum       = '71ed6a10f0701ef919e6bcf95b97c1fa0ae783f7eeb6581309129543f9bf8074'
    checksumType   = 'sha256'
    checksum64     = '566e33b5370f64f0b5f379a1ca3d6f5b378e30080f9f1e5cd88e806e59389d15'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
