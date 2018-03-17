$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'marble'
    fileType       = 'exe'
    url            = 'https://files.kde.org/marble/downloads/windows/Marble-setup_2.2.0_x86.exe'
    url64bit       = 'https://files.kde.org/marble/downloads/windows/Marble-setup_2.2.0-1_x64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '3820dbdc7b14db52454057dc1b8ba167831a70e102b7da200e1e20b945d81012'
    checksumType   = 'sha256'
    checksum64     = '10b47fb07cae61d48ea9ade811261d3a7ff26b5e96f362e663a583d4d8773e10'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
