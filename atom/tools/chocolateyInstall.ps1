$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    softwareName   = 'Atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.36.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.36.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '1b3b693b73e245668b9d3c28e879072b34af56f5e5bc25f5f03b2b5ec078ddf4'
    checksumType   = 'sha256'
    checksum64     = '4a4adcf81737e56a13e25cf79fdf9955d8bc665c959e32df3bcb660a7812f341'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
