$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'avgantivirusfree'
  fileType       = 'exe'
  url            = 'http://files-download.avg.com/inst/mp/Antivirus_Free_x86_1819.exe'
  url64bit       = 'http://files-download.avg.com/inst/mp/Antivirus_Free_x64_1818.exe'
  silentArgs     = "/mode=offline /install=fmw,zen,bav /langid=$((Get-UICulture).LCID) /silent=true"
  checksum       = '353f1e6499403f0dd23ffd4c442ce335106acbf7772aa5bd27bd17c8d837760d'
  checksumType   = 'sha256'
  checksum64     = '353f1e6499403f0dd23ffd4c442ce335106acbf7772aa5bd27bd17c8d837760d'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
