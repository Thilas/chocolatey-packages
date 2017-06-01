$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'strawberryperl'
  fileType       = 'msi'
  url            = 'http://strawberryperl.com/download/5.26.0.1/strawberry-perl-5.26.0.1-32bit.msi'
  url64bit       = 'http://strawberryperl.com/download/5.26.0.1/strawberry-perl-5.26.0.1-64bit.msi'
  silentArgs     = '/qn /norestart'
  checksum       = '1d008b416a48628cc14bd8b9e1e1eb65c331cc627c792d2946a88aa9aa0aecb7'
  checksumType   = 'sha256'
  checksum64     = 'dfe155ce2805b8a23f6706057a37f66657f21f24bd01e79a27e28aefc7b524d4'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
