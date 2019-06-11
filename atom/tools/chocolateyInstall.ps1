$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    softwareName   = 'Atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.39.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.39.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '6eeeea3d399d81cfc9e229df0226f9ddf6c3f422bf39ffac1c57748afc645570'
    checksumType   = 'sha256'
    checksum64     = 'cd5c72549a6d841cc8a1b398241fec0a8e99522e7b08d39fbf7540342116f026'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
