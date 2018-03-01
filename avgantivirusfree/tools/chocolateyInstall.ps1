$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'avgantivirusfree'
  fileType       = 'exe'
  url            = 'http://files-download.avg.com/inst/mp/Antivirus_Free_x86_1819.exe'
  url64bit       = 'http://files-download.avg.com/inst/mp/Antivirus_Free_x64_1818.exe'
  silentArgs     = "/mode=offline /install=fmw,zen,bav /langid=$((Get-UICulture).LCID) /silent=true"
  checksum       = 'cbd5f8bde410f6517dc40a9fdc6c903b44034c3e5ed163417ac7e82375a7f14b'
  checksumType   = 'sha256'
  checksum64     = 'cbd5f8bde410f6517dc40a9fdc6c903b44034c3e5ed163417ac7e82375a7f14b'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
