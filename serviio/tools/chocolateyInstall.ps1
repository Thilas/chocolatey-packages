$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'serviio'
    softwareName   = 'Serviio'
    fileType       = 'exe'
    url            = 'https://download.serviio.org/releases/serviio-2.4-win-setup.exe'
    silentArgs     = '/S'
    checksum       = '6138e48400e9c9bdfbd6e57a5e5c2292496abb1a403e2728ab5415ea6942e77c'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
