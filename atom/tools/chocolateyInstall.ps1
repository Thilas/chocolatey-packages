$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'atom'
  fileType       = 'exe'
  url            = 'https://github.com/atom/atom/releases/download/v1.24.0-beta0/AtomSetup.exe'
  url64bit       = 'https://github.com/atom/atom/releases/download/v1.24.0-beta0/AtomSetup-x64.exe'
  silentArgs     = '--silent'
  checksum       = '3f92ba81b0c574d1937c51107260a99b77b03b75d0364328c8cbccc25c33cfea'
  checksumType   = 'sha256'
  checksum64     = '1197719414c9b554d382a9d4c117d5df23be0adf0f58b04a9db59c96befc0962'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
