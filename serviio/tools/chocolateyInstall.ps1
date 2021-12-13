$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'serviio'
    softwareName   = 'Serviio'
    fileType       = 'exe'
    url            = 'https://download.serviio.org/releases/serviio-2.2.1-win-setup.exe'
    silentArgs     = '/S'
    checksum       = '1ded8d36e953db9ee9496edba444318649f9071dbe434c6cb386b09dce747621'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
