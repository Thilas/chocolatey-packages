$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    softwareName   = 'Atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.38.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.38.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = 'aee4e7e7f609d6add7391319beed5e9a70eecd92d469e7ddf6d77ef7c05ea345'
    checksumType   = 'sha256'
    checksum64     = '6a717d0ad51772761b0e93227992ccb9d3476c933a22e9bba25e2b7ad9481fd8'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
