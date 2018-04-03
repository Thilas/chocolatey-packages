$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'avgantivirusfree'
    fileType       = 'exe'
    url            = 'https://files-download.avg.com/inst/mp/Antivirus_Free_x86_1819.exe'
    url64bit       = 'https://files-download.avg.com/inst/mp/Antivirus_Free_x64_1818.exe'
    silentArgs     = "/mode=offline /install=fmw,zen,bav /langid=$((Get-UICulture).LCID) /silent=true"
    checksum       = 'b57bdf817579f037b2ec8cbd8e8bde0ca9602620f2d3226bcdbf2f698d5a2b55'
    checksumType   = 'sha256'
    checksum64     = 'b57bdf817579f037b2ec8cbd8e8bde0ca9602620f2d3226bcdbf2f698d5a2b55'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
