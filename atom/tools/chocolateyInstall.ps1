$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.33.0-beta1/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.33.0-beta1/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '848443f7cd24c0e2193fef54a588dd6abddcc3b3e54d3e2f7e7834162293bb06'
    checksumType   = 'sha256'
    checksum64     = '95abf25310691c5421eb938487f21bcd225a059da82f68136f4dcc19bd2b3e9d'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
