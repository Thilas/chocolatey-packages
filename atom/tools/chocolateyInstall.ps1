$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    softwareName   = 'Atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.39.0-beta3/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.39.0-beta3/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '528b937eeba02c0e1d688cc93d6b3166d7624749dea86afffdfe330efa76e58d'
    checksumType   = 'sha256'
    checksum64     = 'f3132083b90d8c17ef0879ac5d1ba9657428a3cf5b72106375ec10f71da919c6'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
