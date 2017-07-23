$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'serviio'
  fileType       = 'exe'
  url            = 'http://download.serviio.org/releases/serviio-1.9-win-setup.exe'
  silentArgs     = '/S'
  checksum       = 'd4e4715ed12895f22fbc9c34de676b23c3ac0927e763b43fb8cec97f894bf687'
  checksumType   = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
