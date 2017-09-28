$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'atom'
  fileType       = 'exe'
  url            = 'https://github.com/atom/atom/releases/download/v1.20.1/AtomSetup.exe'
  url64bit       = 'https://github.com/atom/atom/releases/download/v1.20.1/AtomSetup-x64.exe'
  silentArgs     = '--silent'
  checksum       = '1a7ced4f19412af0c6975eedb4dc55ef9084ce005bcfda561c8a6f3c7a8b80e6'
  checksumType   = 'sha256'
  checksum64     = '24a36156f3137e23886bbe3a6c212c636f303d01a6cfc9efba8669196e4c8d6b'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
