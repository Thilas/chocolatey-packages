$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
  packageName    = ''
  url            = ''
  unzipLocation  = $toolsDir
  checksum       = ''
  checksumType   = ''
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

New-Item (Join-Path $toolsDir "$packageName.exe.gui") -Type file -Force | Out-Null
