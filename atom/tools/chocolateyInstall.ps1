$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'atom'
  fileType       = 'exe'
  url            = 'https://github.com/atom/atom/releases/download/v1.25.0-beta0/AtomSetup.exe'
  url64bit       = 'https://github.com/atom/atom/releases/download/v1.25.0-beta0/AtomSetup-x64.exe'
  silentArgs     = '--silent'
  checksum       = '297f43af40a4f092d4bdd5b9e4f1105fcb9f11ba65e2cd1cc45e7f5e00d5526d'
  checksumType   = 'sha256'
  checksum64     = '190babc512dffe85e48d1e364fdafb36a985b2a76d4fd571bb09a7e7ef53debd'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
