$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'avgantivirusfree'
  fileType       = 'exe'
  url            = 'https://files-download.avg.com/inst/mp/Antivirus_Free_x86_1819.exe'
  url64bit       = 'https://files-download.avg.com/inst/mp/Antivirus_Free_x64_1818.exe'
  silentArgs     = "/mode=offline /install=fmw,zen,bav /langid=$((Get-UICulture).LCID) /silent=true"
  checksum       = '17ea4e1ca5658e8adf3a526f38a20d2a9c4f4c1911bf6efff8db9c14c769bc03'
  checksumType   = 'sha256'
  checksum64     = '197e26b2863125707bb38e765f0e5910e2941f3e07ba59fe59a491c7a19d7b0c'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
