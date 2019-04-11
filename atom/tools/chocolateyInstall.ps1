$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    softwareName   = 'Atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.37.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.37.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = 'f67d574e41ad65b0527dc781c6ac67397734f89c4f86a7b79241d998e8dea83e'
    checksumType   = 'sha256'
    checksum64     = '481014ac64865990391054d54cfde77aa329e5f1cb9c5fd75381f4ee27f1a10e'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
