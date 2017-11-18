$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'atom'
  fileType       = 'exe'
  url            = 'https://github.com/atom/atom/releases/download/v1.23.0-beta1/AtomSetup.exe'
  url64bit       = 'https://github.com/atom/atom/releases/download/v1.23.0-beta1/AtomSetup-x64.exe'
  silentArgs     = '--silent'
  checksum       = '8cb0b6411df5ff7f49d358ca13f461546eada55d08fe8e44c33395f6d9436213'
  checksumType   = 'sha256'
  checksum64     = '5c7e20053ee87783a51f0d15b0e56089d1ac9f494e77dadcb7510b1cc36ae75f'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
