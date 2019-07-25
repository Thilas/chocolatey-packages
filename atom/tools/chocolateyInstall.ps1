$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    softwareName   = 'Atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.40.0-beta1/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.40.0-beta1/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = 'a82f0a019cf7b5829823d572511d89377948d7781e18b07ac1af0eebfc039002'
    checksumType   = 'sha256'
    checksum64     = 'b23d014effc6cb3ceec801ca4ede6299f98df9613241ea8d782da009a076e5ea'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
