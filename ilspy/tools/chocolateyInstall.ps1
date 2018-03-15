$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'ilspy'
  url            = 'https://github.com/icsharpcode/ILSpy/releases/download/v3.0.1/ILSpy_binaries_Net46_Win_3.0.1.3459.zip'
  unzipLocation  = $toolsDir
  checksum       = '5aca34b25fa416cc76af3a98d663791d951fdd6455f2d8b4e9e4520a315e4346'
  checksumType   = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

New-Item (Join-Path $toolsDir "$packageName.exe.gui") -Type file -Force | Out-Null
