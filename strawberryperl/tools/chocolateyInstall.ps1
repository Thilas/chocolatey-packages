$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'strawberryperl'
    softwareName   = 'Strawberry Perl *'
    fileType       = 'msi'
    url64bit       = 'https://github.com/StrawberryPerl/Perl-Dist-Strawberry/releases/download/SP_53821_64bit/strawberry-perl-5.38.2.1-64bit.msi'
    silentArgs     = '/qn /norestart'
    checksum64     = 'faf79086776585a297b4cb58ac017a9acda45cb71942c1aa28d18987b1659e3b'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
