$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'strawberryperl'
  fileType       = 'msi'
  url            = 'http://strawberryperl.com/download/5.24.0.1/strawberry-perl-5.24.0.1-32bit.msi'
  url64bit       = 'http://strawberryperl.com/download/5.24.0.1/strawberry-perl-5.24.0.1-64bit.msi'
  silentArgs     = '/qn /norestart'
  checksum       = '8b9f827f1507c926bffa44ed1bfaf1ba1612a18235a60b6c883f3914038411f2'
  checksumType   = 'sha256'
  checksum64     = '618bc243993e3f2172c6ce9d2e02bb2e111927e9bda4e500a04d6bd8ef43b371'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
