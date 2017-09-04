$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'strawberryperl'
  fileType       = 'msi'
  url            = 'http://strawberryperl.com/download/5.26.0.2/strawberry-perl-5.26.0.2-32bit.msi'
  url64bit       = 'http://strawberryperl.com/download/5.26.0.2/strawberry-perl-5.26.0.2-64bit.msi'
  silentArgs     = '/qn /norestart'
  checksum       = '616012ffea155a74d0ce9d6c49f258e6b622327b0e00145c34a279d98fba33f6'
  checksumType   = 'sha256'
  checksum64     = '6c8fe0ee1dae171b5291898e960581e7ec7ef374c5928ae042164bc308a051f4'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
