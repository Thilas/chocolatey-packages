$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'serviio'
    softwareName   = 'Serviio'
    fileType       = 'exe'
    url            = 'https://download.serviio.org/releases/serviio-2.2-win-setup.exe'
    silentArgs     = '/S'
    checksum       = '1d9e94ded3a293e930c8b541e6b8c5632dc75ce8af7c110d0875bf8de9cf681d'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
