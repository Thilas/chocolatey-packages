$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'avgantivirusfree'
    fileType       = 'exe'
    url            = 'https://files-download.avg.com/inst/mp/Antivirus_Free_x86_1819.exe'
    url64bit       = 'https://files-download.avg.com/inst/mp/Antivirus_Free_x64_1818.exe'
    silentArgs     = "/mode=offline /install=fmw,zen,bav /langid=$((Get-UICulture).LCID) /silent=true"
    checksum       = '1f3ebcc99bcfb2f5f48f404cda2fe39ea8a914c6610eb9e3dbb7cf36077dd93d'
    checksumType   = 'sha256'
    checksum64     = '1f3ebcc99bcfb2f5f48f404cda2fe39ea8a914c6610eb9e3dbb7cf36077dd93d'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
