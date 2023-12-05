$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'strawberryperl'
    softwareName   = 'Strawberry Perl *'
    fileType       = 'msi'
    url64bit       = 'https://github.com/StrawberryPerl/Perl-Dist-Strawberry/releases/download/SP_53631_64bit/strawberry-perl-5.36.3.1-64bit.msi'
    silentArgs     = '/qn /norestart'
    checksum64     = 'f4fb3ac04f4eb1d1f38d56b2fb5d9a066e91606e6e2fea797095a63bee0163ab'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
