$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'strawberryperl'
    softwareName   = 'Strawberry Perl *'
    fileType       = 'msi'
    url            = 'http://strawberryperl.com/download/5.30.0.1/strawberry-perl-5.30.0.1-32bit.msi'
    url64bit       = 'http://strawberryperl.com/download/5.30.0.1/strawberry-perl-5.30.0.1-64bit.msi'
    silentArgs     = '/qn /norestart'
    checksum       = '94e19ffb75faff7182fb7b17ebf471460b3a452ff853f4bee95e114a74d0b8f7'
    checksumType   = 'sha256'
    checksum64     = '459de13a284a4c83213208c9caa1c372c81136b6e863a3f13d42f631048e0b12'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
