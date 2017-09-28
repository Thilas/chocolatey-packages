$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'atom'
  fileType       = 'exe'
  url            = 'https://atom.io/download/windows'
  url64bit       = ''
  silentArgs     = '--silent'
  checksum       = ''
  checksumType   = ''
  checksum64     = ''
  checksumType64 = ''
  validExitCodes = @()
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
