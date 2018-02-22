$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'atom'
  fileType       = 'exe'
  url            = 'https://github.com/atom/atom/releases/download/v1.25.0-beta2/AtomSetup.exe'
  url64bit       = 'https://github.com/atom/atom/releases/download/v1.25.0-beta2/AtomSetup-x64.exe'
  silentArgs     = '--silent'
  checksum       = '519f478b36e1b00c3bee6045d64b11bd116460b07a12a2babfecce6a2d16039a'
  checksumType   = 'sha256'
  checksum64     = '991c2c16190bfa7d23167093418b487934cea0da50e61d2d1eb5caf2c5994a88'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
