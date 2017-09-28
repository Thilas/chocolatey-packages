$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'strawberryperl'
  fileType       = 'msi'
  url            = 'http://strawberryperl.com/download/5.26.1.1/strawberry-perl-5.26.1.1-32bit.msi'
  url64bit       = 'http://strawberryperl.com/download/5.26.1.1/strawberry-perl-5.26.1.1-64bit.msi'
  silentArgs     = '/qn /norestart'
  checksum       = 'e03937f4359976f1e4f82ea8740d785aef6ede9b4d12b92ebb88860c5a7405eb'
  checksumType   = 'sha256'
  checksum64     = '937bb91352a37f569c7b03f38f5be081fc7928d3a232cc27d34b2a145e5b60b8'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
