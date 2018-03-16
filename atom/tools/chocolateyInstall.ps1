$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'atom'
  fileType       = 'exe'
  url            = 'https://github.com/atom/atom/releases/download/v1.26.0-beta0/AtomSetup.exe'
  url64bit       = 'https://github.com/atom/atom/releases/download/v1.26.0-beta0/AtomSetup-x64.exe'
  silentArgs     = '--silent'
  checksum       = 'e2904c6f86acf65a0847f7904a5e22c492bc10bddf90f5db5e46fc07e6c92acb'
  checksumType   = 'sha256'
  checksum64     = '96b6d4859d711f3a739bac3f1dbd2bd627d51433ae458f82828d1caf134ec03b'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
