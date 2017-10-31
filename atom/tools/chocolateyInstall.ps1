$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'atom'
  fileType       = 'exe'
  url            = 'https://github.com/atom/atom/releases/download/v1.22.0-beta2/AtomSetup.exe'
  url64bit       = 'https://github.com/atom/atom/releases/download/v1.22.0-beta2/AtomSetup-x64.exe'
  silentArgs     = '--silent'
  checksum       = 'e0a9dd5f2ea0c9688c2878bb515dafb8cb18efb7483c15bf142335a15b7b8dd8'
  checksumType   = 'sha256'
  checksum64     = '4f1d8299d39f2313cd55822cad4899f38abfd233aae2d2b29fc58f56ddb97aee'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
