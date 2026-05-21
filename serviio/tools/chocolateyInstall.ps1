$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'serviio'
    softwareName   = 'Serviio'
    fileType       = 'exe'
    url            = 'https://download.serviio.org/releases/serviio-2.5-win-setup.exe'
    silentArgs     = '/S'
    checksum       = '2ad081acd0973f1765a4d65f67d573de62f60d9e16536cea136f62f8a61237c7'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
