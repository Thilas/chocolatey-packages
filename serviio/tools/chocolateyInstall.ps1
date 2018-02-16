$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'serviio'
  fileType       = 'exe'
  url            = 'http://download.serviio.org/releases/serviio-1.9.1-win-setup.exe'
  silentArgs     = '/S'
  checksum       = '8b5b8e2e86a8e9dc0691b8e1fed98cfc1cc3f03802a67bfbc6bc54dbceac352f'
  checksumType   = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
