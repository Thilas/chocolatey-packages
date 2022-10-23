$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'serviio'
    softwareName   = 'Serviio'
    fileType       = 'exe'
    url            = 'https://download.serviio.org/releases/serviio-2.3-win-setup.exe'
    silentArgs     = '/S'
    checksum       = '901bea15f950b6da1b3f188eb7d6a9307d7693c952d1581da14a2f923f802a6d'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
