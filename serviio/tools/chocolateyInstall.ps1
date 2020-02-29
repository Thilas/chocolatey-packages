$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'serviio'
    softwareName   = 'Serviio'
    fileType       = 'exe'
    url            = 'https://download.serviio.org/releases/serviio-2.0-win-setup.exe'
    silentArgs     = '/S'
    checksum       = 'e62fbf69279d0988f1c44f11a9361064c4542eff04f20f0df5c1fb5933140874'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
