# stop on all errors
$ErrorActionPreference = 'Stop';
 
$packageName = 'lavfilters'
$registryUninstallerKeyName = 'lavfilters_is1'
$shouldUninstall = $true

$local_key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\$registryUninstallerKeyName"
$local_key6432 = "HKCU:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$registryUninstallerKeyName"
$machine_key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$registryUninstallerKeyName"
$machine_key6432 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$registryUninstallerKeyName"

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

$installerType = 'exe'
$silentArgs = '/SILENT'
$validExitCodes = @(0)

if ($shouldUninstall -and !(Test-Path $file)) {
  Write-Host "$packageName has already been uninstalled by other means."
  $shouldUninstall = $false
}

if ($shouldUninstall) {
  Uninstall-ChocolateyPackage -PackageName $packageName -FileType $installerType -SilentArgs $silentArgs -validExitCodes $validExitCodes -File $file
}
