$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'strawberryperl'
  fileType       = 'msi'
  url            = 'http://strawberryperl.com/download/5.24.1.1/strawberry-perl-5.24.1.1-32bit.msi'
  url64bit       = 'http://strawberryperl.com/download/5.24.1.1/strawberry-perl-5.24.1.1-64bit.msi'
  silentArgs     = '/qn /norestart'
  checksum       = '9ecd562f5fe5abda0002918b4957546410632ec22142a04c247fe67d04a84f6a'
  checksumType   = 'sha256'
  checksum64     = '1af88019b3d108c465521de44c90699c11696c1ccdd18a50bf7e884f51dd5f24'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
