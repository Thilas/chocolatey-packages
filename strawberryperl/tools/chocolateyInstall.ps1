$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'strawberryperl'
    softwareName   = 'Strawberry Perl *'
    fileType       = 'msi'
    url            = 'http://strawberryperl.com/download/5.30.3.1/strawberry-perl-5.30.3.1-32bit.msi'
    url64bit       = 'http://strawberryperl.com/download/5.30.3.1/strawberry-perl-5.30.3.1-64bit.msi'
    silentArgs     = '/qn /norestart'
    checksum       = '64f51b7ea411796fd4ce5193450058dc5d1bc143cf1f882de559630b0acce62e'
    checksumType   = 'sha256'
    checksum64     = '7e853ae54e2ab600385b81ddb7259f1e47aa876bdd3aee75f248754da7995ecb'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
