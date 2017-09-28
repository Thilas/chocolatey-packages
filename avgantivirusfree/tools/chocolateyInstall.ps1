$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'avgantivirusfree'
  fileType       = 'exe'
  url            = 'https://files-download.avg.com/inst/mp/Antivirus_Free_x86_1819.exe'
  url64bit       = 'https://files-download.avg.com/inst/mp/Antivirus_Free_x64_1818.exe'
  silentArgs     = "/mode=offline /install=fmw,zen,bav /langid=$((Get-UICulture).LCID) /silent=true"
  checksum       = 'ab910549ed460b7b9c19f3a57492eb8685b93da40d7f5cb21f395a1b5c28839c'
  checksumType   = 'sha256'
  checksum64     = '38a12cbdc4b8494be0c64052e45727fb19535416af217d8b2798274e916e52d3'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
