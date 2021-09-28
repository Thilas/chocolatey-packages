$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v0.21.2/stellarium-0.21.2-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v0.21.2/stellarium-0.21.2-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = 'd98169a9d268ba4289f6f9a49add7c2bd4a7a2e17158c52ea1712ca66affaa65'
    checksumType   = 'sha256'
    checksum64     = 'eff51315b0d3200ef0ecbb8deb8ffc3fe649162b32d577bf5701953709588af0'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
