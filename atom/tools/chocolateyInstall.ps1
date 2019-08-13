$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    softwareName   = 'Atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.41.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.41.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = 'd91e8cb7115428c8ea39642dfe462abdc0ccfc38f95334d854838db2a561c3dc'
    checksumType   = 'sha256'
    checksum64     = '2ffc51bac1348465e47d480757b0e7232b43deeeba3e0e1d4ea64270249d2c43'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
