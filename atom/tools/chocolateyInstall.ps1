$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'atom'
  fileType       = 'exe'
  url            = 'https://github.com/atom/atom/releases/download/v1.21.0-beta2/AtomSetup.exe'
  url64bit       = 'https://github.com/atom/atom/releases/download/v1.21.0-beta2/AtomSetup-x64.exe'
  silentArgs     = '--silent'
  checksum       = '5906c7720a0b8ee06f0ae8d9a98183f292b15a18d3937bafd28e7af374f74d84'
  checksumType   = 'sha256'
  checksum64     = '81ff468401d4f00dc868cbd3744f911a9e443a1bc1a6be1082077de8bb40898f'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
