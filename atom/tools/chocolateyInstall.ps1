$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'atom'
  fileType       = 'exe'
  url            = 'https://github.com/atom/atom/releases/download/v1.24.0-beta1/AtomSetup.exe'
  url64bit       = 'https://github.com/atom/atom/releases/download/v1.24.0-beta1/AtomSetup-x64.exe'
  silentArgs     = '--silent'
  checksum       = 'eebbd8dad373819a44ab91e197de8003dba76c1907a93a7bda632aecabce2d44'
  checksumType   = 'sha256'
  checksum64     = '30e064ed74db87e5e2aca97b1ad467763f6e39e35786cfee189b1d6000a6fe11'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
