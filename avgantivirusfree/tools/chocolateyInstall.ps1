$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'avgantivirusfree'
  fileType       = 'exe'
  url            = 'https://files-download.avg.com/inst/mp/Antivirus_Free_x86_1819.exe'
  url64bit       = 'https://files-download.avg.com/inst/mp/Antivirus_Free_x64_1818.exe'
  silentArgs     = "/mode=offline /install=fmw,zen,bav /langid=$((Get-UICulture).LCID) /silent=true"
  checksum       = '90e96176b0433ca5d4ca976fdb99c845d9c85dfa4ced42dc558c436bf0f09eac'
  checksumType   = 'sha256'
  checksum64     = '5cfd5d6e89cf79e711239ecaaa70fe1b9bd43afdca369a74f078d644f886ea52'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
