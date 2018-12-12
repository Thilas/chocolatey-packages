$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'strawberryperl'
    fileType       = 'msi'
    url            = 'http://strawberryperl.com/download/5.28.1.1/strawberry-perl-5.28.1.1-32bit.msi'
    url64bit       = 'http://strawberryperl.com/download/5.28.1.1/strawberry-perl-5.28.1.1-64bit.msi'
    silentArgs     = '/qn /norestart'
    checksum       = '5966c7134f2bdcdf563a71e8905511932b7815fa5f1ddb65e670a4518d535d09'
    checksumType   = 'sha256'
    checksum64     = '99a8d7230537c01e8a82dc6635392ec15a770202f868f631781b21aee5cd805c'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
