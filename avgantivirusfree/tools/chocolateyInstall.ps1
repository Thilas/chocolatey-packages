$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'avgantivirusfree'
  fileType       = 'exe'
  url            = 'http://files-download.avg.com/inst/mp/Antivirus_Free_x86_1819.exe'
  url64bit       = 'http://files-download.avg.com/inst/mp/Antivirus_Free_x64_1818.exe'
  silentArgs     = "/mode=offline /install=fmw,zen,bav /langid=$((Get-UICulture).LCID) /silent=true"
  checksum       = '7fdde5dd24b8eb3f20fbb8aa7334dcdd4ce3fdc089d3b120c55597e0076fed42'
  checksumType   = 'sha256'
  checksum64     = '7fdde5dd24b8eb3f20fbb8aa7334dcdd4ce3fdc089d3b120c55597e0076fed42'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
