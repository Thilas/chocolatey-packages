$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'atom'
  fileType       = 'exe'
  url            = 'https://github.com/atom/atom/releases/download/v1.22.0-beta1/AtomSetup.exe'
  url64bit       = 'https://github.com/atom/atom/releases/download/v1.22.0-beta1/AtomSetup-x64.exe'
  silentArgs     = '--silent'
  checksum       = 'fa708088a3e7d3e8050dc8bbc6eb933fcd761aa66c423f1f523bbe68d1e30a3b'
  checksumType   = 'sha256'
  checksum64     = 'aa6f4d759aef9edd5b5739de70baf79e5c582026e9c14af96e025144c10c75b6'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
