$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'strawberryperl'
    fileType       = 'msi'
    url            = 'http://strawberryperl.com/download/5.24.3.1/strawberry-perl-5.24.3.1-32bit.msi'
    url64bit       = 'http://strawberryperl.com/download/5.24.3.1/strawberry-perl-5.24.3.1-64bit.msi'
    silentArgs     = '/qn /norestart'
    checksum       = 'e75f8c3d4849f17b519d4551d15aa4087486fca07239640f600b8aac5e7963f0'
    checksumType   = 'sha256'
    checksum64     = 'a9414cbb26198780fef5894e4980177f3b2dc1c50b6a651b49e467af9c315759'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
