$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'strawberryperl'
    softwareName   = 'Strawberry Perl *'
    fileType       = 'msi'
    url            = 'https://strawberryperl.com/download/5.32.1.1/strawberry-perl-5.32.1.1-32bit.msi'
    url64bit       = 'https://strawberryperl.com/download/5.32.1.1/strawberry-perl-5.32.1.1-64bit.msi'
    silentArgs     = '/qn /norestart'
    checksum       = '5d36fe3464169154c8d2d437ab368bbd54539eafee2c107dab53b1a86a658f1b'
    checksumType   = 'sha256'
    checksum64     = '241a881670164feb0b91bb69d39fbbf84c981bec0d9f8c19959f8f48fd177768'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
