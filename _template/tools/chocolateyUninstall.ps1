# stop on all errors
$ErrorActionPreference = 'Stop';
 
# *** Automatically filled ***
$packageName              = ''
$uninstallRegistryKeyName = ''
$uninstallFileType        = ''
$uninstallSilentArgs      = ''
$uninstallValidExitCodes  = @(0)
# *** Automatically filled ***

$shouldUninstall = $true

$local_key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\$uninstallRegistryKeyName"
$local_key6432 = "HKCU:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$uninstallRegistryKeyName"
$machine_key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$uninstallRegistryKeyName"
$machine_key6432 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$uninstallRegistryKeyName"

$file = @($local_key, $local_key6432, $machine_key, $machine_key6432) `
  | ?{ Test-Path $_ } `
  | Get-ItemProperty `
  | Select-Object -ExpandProperty UninstallString

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
