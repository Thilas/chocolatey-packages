$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'avgantivirusfree'
  fileType       = 'exe'
  url            = 'http://files-download.avg.com/inst/mp/Antivirus_Free_x86_1819.exe'
  url64bit       = 'http://files-download.avg.com/inst/mp/Antivirus_Free_x64_1818.exe'
  silentArgs     = "/mode=offline /install=fmw,zen,bav /langid=$((Get-UICulture).LCID) /silent=true"
  checksum       = 'c2db9fa6d0ac417d819cf8975670a2e35851097f86a1fceaf56400d1c2539a34'
  checksumType   = 'sha256'
  checksum64     = '6647f490bcbdd9477e3b935ec6b3cda43da64b4fecc4d2dcf8c34b948ff08362'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
