$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'serviio'
    softwareName   = ''
    fileType       = 'exe'
    url            = 'http://download.serviio.org/releases/serviio-1.10-win-setup.exe'
    silentArgs     = '/S'
    checksum       = '421f75ac0d57e45096c9f697e02825f926c84a78cc3e7d04093aa30521f22bc0'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
