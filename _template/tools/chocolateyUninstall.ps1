# stop on all errors
$ErrorActionPreference = 'Stop';
 
# *** Automatically filled ***
$packageName             = ''
$uninstallSoftwareName   = ''
$uninstallFileType       = ''
$uninstallSilentArgs     = ''
$uninstallValidExitCodes = @(0)
# *** Automatically filled ***

$shouldUninstall = $true

[array]$key = Get-UninstallRegistryKey -SoftwareName $uninstallSoftwareName
$file = $key.UninstallString

if ($file -eq $null -or $file -eq '') {
  Write-Host "$packageName has already been uninstalled by other means."
  $shouldUninstall = $false
}
else {
  $file = $file.Replace('"', '')
}

if ($shouldUninstall -and !(Test-Path $file)) {
  Write-Host "$packageName has already been uninstalled by other means."
  $shouldUninstall = $false
}

if ($shouldUninstall) {
  Uninstall-ChocolateyPackage -PackageName $packageName -FileType $uninstallFileType -SilentArgs $uninstallSilentArgs -validExitCodes $uninstallValidExitCodes -File $file
}
