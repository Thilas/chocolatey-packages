$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'strawberryperl'
    softwareName   = 'Strawberry Perl *'
    fileType       = 'msi'
    url64bit       = 'https://github.com/StrawberryPerl/Perl-Dist-Strawberry/releases/download/SP_5.39.10/strawberry-perl-5.39.10.1-64bit.msi'
    silentArgs     = '/qn /norestart'
    checksum64     = '5790b129adfb86dbb03236137415638eb818c4c75f5c49c065c7315084861d31'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
