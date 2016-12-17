# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'imdisk'
  fileType       = 'exe'
  url            = 'http://www.ltr-data.se/files/imdiskinst_2.0.9.exe'
  silentArgs     = '-y'
  checksum       = '11a0d1c855c7f085c98a2fbaba92a14372e479510c9f6f8bed1e8ec449d1e5f1'
  checksumType   = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

$installOverride = $env:chocolateyInstallOverride
if (!$installOverride) {
  $env:IMDISK_SILENT_SETUP = 1
  Write-Host "Silent mode set"
}

Install-ChocolateyPackage @packageArgs
