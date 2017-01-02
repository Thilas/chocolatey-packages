$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'strawberryperl'
  fileType       = 'msi'
  url            = 'http://strawberryperl.com/download/5.20.1.1/strawberry-perl-5.20.1.1-32bit.msi'
  url64bit       = 'http://strawberryperl.com/download/5.20.1.1/strawberry-perl-5.20.1.1-64bit.msi'
  silentArgs     = '/qn'
  checksum       = ''
  checksumType   = ''
  checksum64     = ''
  checksumType64 = ''
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
