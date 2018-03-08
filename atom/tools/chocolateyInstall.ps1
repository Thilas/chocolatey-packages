$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'atom'
  fileType       = 'exe'
  url            = 'https://github.com/atom/atom/releases/download/v1.25.0-beta3/AtomSetup.exe'
  url64bit       = 'https://github.com/atom/atom/releases/download/v1.25.0-beta3/AtomSetup-x64.exe'
  silentArgs     = '--silent'
  checksum       = '0ccf108cabb97cb70ab2c1e02a907ac3d4ffe366198d75fa52d413e7d0f33215'
  checksumType   = 'sha256'
  checksum64     = '4815085a023738573dcceb8d15edd400cb76a86849f6554fd65e0727072840fa'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
