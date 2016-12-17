# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'hashcheck'
  fileType       = 'exe'
  url            = 'https://github.com/gurnec/HashCheck/releases/download/v2.4.0/HashCheckSetup-v2.4.0.exe'
  silentArgs     = '/S'
  checksum       = '2d6067f00bbb93526d146d2228a46dc4851f0fa866e69250279c6b2f00b8f1b7'
  checksumType   = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
