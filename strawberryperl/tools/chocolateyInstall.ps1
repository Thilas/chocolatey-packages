$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'strawberryperl'
    softwareName   = 'Strawberry Perl *'
    fileType       = 'msi'
    url            = 'http://strawberryperl.com/download/5.30.2.1/strawberry-perl-5.30.2.1-32bit.msi'
    url64bit       = 'http://strawberryperl.com/download/5.30.2.1/strawberry-perl-5.30.2.1-64bit.msi'
    silentArgs     = '/qn /norestart'
    checksum       = '2365e89623b496ca530443a362e765f3e8de9daa744b07924b17ae7aa0b06002'
    checksumType   = 'sha256'
    checksum64     = '2476f4e2128210c40f7621e9379f5a46a53f015fa7b1bc26b1806acda13c4244'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
