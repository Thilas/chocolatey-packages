$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'atom'
  fileType       = 'exe'
  url            = 'https://github.com/atom/atom/releases/download/v1.23.1/AtomSetup.exe'
  url64bit       = 'https://github.com/atom/atom/releases/download/v1.23.1/AtomSetup-x64.exe'
  silentArgs     = '--silent'
  checksum       = '3e9d695935d000a0692e10e678dc3fb0d51e2a7a0671b3d3c11e842f276f9a85'
  checksumType   = 'sha256'
  checksum64     = '51249e9825cb87bda75a8b3dea7c282b8f98962eadfa5882a766384f7f391c31'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
