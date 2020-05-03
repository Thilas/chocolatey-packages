$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'serviio'
    softwareName   = 'Serviio'
    fileType       = 'exe'
    url            = 'https://download.serviio.org/releases/serviio-2.1-win-setup.exe'
    silentArgs     = '/S'
    checksum       = '8eed7a46ff2540c95a66ced78b3b8bbe68711d359fbff4ef646f2a8197d76ef4'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
