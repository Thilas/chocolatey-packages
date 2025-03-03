$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'strawberryperl'
    softwareName   = 'Strawberry Perl *'
    fileType       = 'msi'
    url64bit       = 'https://github.com/StrawberryPerl/Perl-Dist-Strawberry/releases/download/sp5.34.3.1/strawberry-perl-5.34.3.1-64bit.msi'
    silentArgs     = '/qn /norestart'
    checksum64     = 'cba8edd3e57280b714daac6a8702a6bc9a7db570dac479b593e8af33b38fc980'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
