$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'ilspy'
  url            = 'https://github.com/icsharpcode/ILSpy/releases/download/v3.1-beta1/ILSpy_binaries_Net46_Win_3.1.0.3599-beta1.zip'
  unzipLocation  = $toolsDir
  checksum       = '3f486a9fb33252fb2d23461795df932f6927c1b9c3cba1f57fe8058c3e6105a3'
  checksumType   = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

New-Item (Join-Path $toolsDir "$packageName.exe.gui") -Type file -Force | Out-Null
