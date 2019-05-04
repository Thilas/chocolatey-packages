$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'strawberryperl'
    softwareName   = 'Strawberry Perl *'
    fileType       = 'msi'
    url            = 'http://strawberryperl.com/download/5.28.2.1/strawberry-perl-5.28.2.1-32bit.msi'
    url64bit       = 'http://strawberryperl.com/download/5.28.2.1/strawberry-perl-5.28.2.1-64bit.msi'
    silentArgs     = '/qn /norestart'
    checksum       = '3644fe7e3875d1b72f145a38bedf23705e2d204992e6743318492e281b1d6d0a'
    checksumType   = 'sha256'
    checksum64     = '3560608e7848166f05513daa23cef4cb247c8993e9ee05ecda42e2d59908c274'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
