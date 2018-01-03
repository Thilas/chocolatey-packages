$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'atom'
  fileType       = 'exe'
  url            = 'https://github.com/atom/atom/releases/download/v1.24.0-beta2/AtomSetup.exe'
  url64bit       = 'https://github.com/atom/atom/releases/download/v1.24.0-beta2/AtomSetup-x64.exe'
  silentArgs     = '--silent'
  checksum       = '7904f1fe175344dcaa8e0c87f076f43f3ff15a623ba30d9682d3506881198593'
  checksumType   = 'sha256'
  checksum64     = '2a6867a3f395dbf9f7be70cbb1de681d41614c8c5e17684633d7c5ba01d3e1ea'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
