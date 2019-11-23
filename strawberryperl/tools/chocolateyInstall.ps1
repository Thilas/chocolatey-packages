$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'strawberryperl'
    softwareName   = 'Strawberry Perl *'
    fileType       = 'msi'
    url            = 'http://strawberryperl.com/download/5.30.1.1/strawberry-perl-5.30.1.1-32bit.msi'
    url64bit       = 'http://strawberryperl.com/download/5.30.1.1/strawberry-perl-5.30.1.1-64bit.msi'
    silentArgs     = '/qn /norestart'
    checksum       = 'eece463db9a0d61063304e0a3a1643a5c7f0b408d90ba7d19bd22788ab88fff7'
    checksumType   = 'sha256'
    checksum64     = 'ee452af861df06a4224a912812546468b10bef22cf5abde57c4e3b01ede98732'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
