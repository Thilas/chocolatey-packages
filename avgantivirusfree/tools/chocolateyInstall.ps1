$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'avgantivirusfree'
    softwareName   = ''
    fileType       = 'exe'
    url            = 'https://files-download.avg.com/inst/mp/Antivirus_Free_x86_1819.exe'
    url64bit       = 'https://files-download.avg.com/inst/mp/Antivirus_Free_x64_1818.exe'
    silentArgs     = "/mode=offline /install=fmw,zen,bav /langid=$((Get-UICulture).LCID) /silent=true"
    checksum       = '1610568975d428105c8ac8647cf32606dd5718570027db7a6cf5491375b527a9'
    checksumType   = 'sha256'
    checksum64     = '1610568975d428105c8ac8647cf32606dd5718570027db7a6cf5491375b527a9'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
