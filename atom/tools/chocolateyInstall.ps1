$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'atom'
  fileType       = 'exe'
  url            = 'https://github.com/atom/atom/releases/download/v1.25.0-beta1/AtomSetup.exe'
  url64bit       = 'https://github.com/atom/atom/releases/download/v1.25.0-beta1/AtomSetup-x64.exe'
  silentArgs     = '--silent'
  checksum       = '1b75b5ca679e57b8f4eab469ccc289aaa1b99583ab1ed21221d1e9f299891162'
  checksumType   = 'sha256'
  checksum64     = '12754073ab74f7c0467b0369eeea607e07e3c108fa4a09c04fb9dddcc54adc5f'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
