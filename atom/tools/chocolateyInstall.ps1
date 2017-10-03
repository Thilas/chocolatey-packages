$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'atom'
  fileType       = 'exe'
  url            = 'https://github.com/atom/atom/releases/download/v1.22.0-beta0/AtomSetup.exe'
  url64bit       = 'https://github.com/atom/atom/releases/download/v1.22.0-beta0/AtomSetup-x64.exe'
  silentArgs     = '--silent'
  checksum       = 'aa80de969d79fbebd62bd93403ea3fa8593086f66bfe340cba473f71f4d034bb'
  checksumType   = 'sha256'
  checksum64     = 'ebe7985fcf8ced631098a43c11d1d8e23b3ed99619de2c20929d9f13bf41961f'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
