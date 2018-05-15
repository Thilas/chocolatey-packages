$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.28.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.28.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '20bf10830a5e0617d746874e2a812346daccb18c1e93d4ad12c6c1ab0465ae28'
    checksumType   = 'sha256'
    checksum64     = '13e0a6c1ff5f64b2c5f9f37334c5aa70b5bd9077ec5e4aa21f867ac2b4c12591'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
