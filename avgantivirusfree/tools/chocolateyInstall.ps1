$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'avgantivirusfree'
    fileType       = 'exe'
    url            = 'https://files-download.avg.com/inst/mp/Antivirus_Free_x86_1819.exe'
    url64bit       = 'https://files-download.avg.com/inst/mp/Antivirus_Free_x64_1818.exe'
    silentArgs     = "/mode=offline /install=fmw,zen,bav /langid=$((Get-UICulture).LCID) /silent=true"
    checksum       = '588d2703ffd941ecb89179c000bd7c814cd6ab4c69e840a0ea7cd85b2c903478'
    checksumType   = 'sha256'
    checksum64     = '588d2703ffd941ecb89179c000bd7c814cd6ab4c69e840a0ea7cd85b2c903478'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
