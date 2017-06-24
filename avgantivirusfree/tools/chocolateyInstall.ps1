$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'avgantivirusfree'
  fileType       = 'exe'
  url            = ''
  url64bit       = ''
  silentArgs     = "/mode=offline /install=fmw,zen,bav /langid=$((Get-UICulture).LCID) /silent=true"
  checksum       = ''
  checksumType   = ''
  checksum64     = ''
  checksumType64 = ''
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
