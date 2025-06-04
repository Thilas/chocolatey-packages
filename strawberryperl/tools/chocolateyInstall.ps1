$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'strawberryperl'
    softwareName   = 'Strawberry Perl *'
    fileType       = 'msi'
    url64bit       = 'https://github.com/StrawberryPerl/Perl-Dist-Strawberry/releases/download/SP_54022_64bit/strawberry-perl-5.40.2.2-64bit.msi'
    silentArgs     = '/qn /norestart'
    checksum64     = 'fa6a45bed5e4b61a2b56d801ea96ec76acd27098310cfd2e8215d74f7fedb2a0'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
