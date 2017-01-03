$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'serviio'
  fileType       = 'exe'
  url            = 'http://download.serviio.org/releases/serviio-1.8-win-setup.exe'
  silentArgs     = '/S'
  checksum       = 'ae10d8b16b01842a6a06a7d28546716fefa3607c244856cb8bc6a8a80aa16acf'
  checksumType   = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
