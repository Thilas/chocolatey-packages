$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'strawberryperl'
    softwareName   = 'Strawberry Perl *'
    fileType       = 'msi'
    url            = 'http://strawberryperl.com/download/5.32.0.1/strawberry-perl-5.32.0.1-32bit.msi'
    url64bit       = 'http://strawberryperl.com/download/5.32.0.1/strawberry-perl-5.32.0.1-64bit.msi'
    silentArgs     = '/qn /norestart'
    checksum       = '29eaad3a53d2b75937e3085d8ecbd4beee302f260687d905dfef5c1d7b26032d'
    checksumType   = 'sha256'
    checksum64     = 'e0e2c1a24b250750134f1b99ed51858c9193d3aafdb5b627dc753c54a01ee033'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
