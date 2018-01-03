$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'avgantivirusfree'
  fileType       = 'exe'
  url            = 'http://files-download.avg.com/inst/mp/Antivirus_Free_x86_1819.exe'
  url64bit       = 'http://files-download.avg.com/inst/mp/Antivirus_Free_x64_1818.exe'
  silentArgs     = "/mode=offline /install=fmw,zen,bav /langid=$((Get-UICulture).LCID) /silent=true"
  checksum       = 'c95ca60a901844a9bb76d417dc55839db04c74d68ab987924366d707923b1c38'
  checksumType   = 'sha256'
  checksum64     = 'd015b93d5907860e598e942fadfe51b8c4a52b32938e830b8d6776dd2463ce09'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
