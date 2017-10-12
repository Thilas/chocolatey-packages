$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'atom'
  fileType       = 'exe'
  url            = 'https://github.com/atom/atom/releases/download/v1.21.1/AtomSetup.exe'
  url64bit       = 'https://github.com/atom/atom/releases/download/v1.21.1/AtomSetup-x64.exe'
  silentArgs     = '--silent'
  checksum       = '7efef302abc1ece629c0cc9be4b771e443b19fdf75db7f028d860ec03d925230'
  checksumType   = 'sha256'
  checksum64     = 'bc84ad0076a3730fd35592c3ee384daff1b27dc3740a0c597ff37f64e26793bc'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
