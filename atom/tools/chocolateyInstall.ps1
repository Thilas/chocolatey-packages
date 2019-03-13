$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    softwareName   = 'Atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.36.0-beta1/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.36.0-beta1/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = 'b7d30248ea574bb72fa54f52469b4cc080f31cdac23275b1fc10cacbab76eb81'
    checksumType   = 'sha256'
    checksum64     = '3a6ca11eaa7a65e64ce67a1b5e9eee8141f95b0c97fec3f044d4f50871a5c5b4'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
