$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'atom'
  fileType       = 'exe'
  url            = 'https://github.com/atom/atom/releases/download/v1.24.0-beta3/AtomSetup.exe'
  url64bit       = 'https://github.com/atom/atom/releases/download/v1.24.0-beta3/AtomSetup-x64.exe'
  silentArgs     = '--silent'
  checksum       = 'dd0173d410300aa72ba06083fe46011bbcb3a835b42fa808d31ac8d006d00905'
  checksumType   = 'sha256'
  checksum64     = 'd7c93404163734cc6a29ce5098e68b7ff0a0345e2711875f2e0406348498fd1e'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
