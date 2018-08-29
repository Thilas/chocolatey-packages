$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.31.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.31.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '9638713f914564a24e4cc3876056dcae9cc4fdb63e97ec54c360bfc6725bcb46'
    checksumType   = 'sha256'
    checksum64     = 'fe5daf647b1aa8a52b89ba03489ebb39a3a6c1f0507546083dcd77e3d33f3a69'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
