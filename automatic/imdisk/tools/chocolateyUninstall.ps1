# stop on all errors
$ErrorActionPreference = 'Stop';
 
$packageName = '{{PackageName}}'
# registry uninstaller key name is the key that is found at HKLM:\Software\Windows\CurrentVersion\Uninstall\ THE NAME
$registryUninstallerKeyName = '{{PackageName}}' #ensure this is the value in the registry
$shouldUninstall = $true

$local_key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\$registryUninstallerKeyName"
# local key 6432 probably never exists
$local_key6432 = "HKCU:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$registryUninstallerKeyName"
$machine_key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$registryUninstallerKeyName"
$machine_key6432 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$registryUninstallerKeyName"

function Resolve-Path {
  param ($file)
  (".;" + $env:PATH).Split(";") | ForEach-Object {
    $testPath = Join-Path $_ $file
    if (Test-Path $testPath) {
      return $testPath
    }
  }
}

$file = @($local_key, $local_key6432, $machine_key, $machine_key6432) `
  | ?{ Test-Path $_ } `
  | Get-ItemProperty `
  | Select-Object -ExpandProperty UninstallString

if ($file -eq $null -or $file -eq '') {
  Write-Host "$packageName has already been uninstalled by other means."
  $shouldUninstall = $false
}

$file = Resolve-Path $file

$installerType = 'exe'
$silentArgs = '-y' # "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT" # try any of these to get the silent installer #msi is always /quiet
$validExitCodes = @(0)

if (!(Test-Path $file)) {
  Write-Host "$packageName has already been uninstalled by other means."
  $shouldUninstall = $false
}

if ($shouldUninstall) {
  $installOverride = $env:chocolateyInstallOverride
  if (!$installOverride) {
    $env:IMDISK_SILENT_SETUP = 1
    Write-Host "Silent mode set"
  }
  
  # Detach all virtual disks
  $exeToRun = 'cmd.exe'
  $statements = '/s /c "if exist "%SystemRoot%\system32\imdisk.exe" for /f %a in (''imdisk -l -n'') do @imdisk -D -u %~a"'
  Start-ChocolateyProcessAsAdmin $statements $exeToRun
  
  Uninstall-ChocolateyPackage -PackageName $packageName -FileType $installerType -SilentArgs $silentArgs -validExitCodes $validExitCodes -File $file
}
