$packageName = 'imdisk'
$fileType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)
$unPath = "HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
$unPathx86 = "HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
$overrideArguments = $env:chocolateyInstallOverride
if (!$overrideArguments)
{
    $env:IMDISK_SILENT_SETUP = 1
    Write-Host "Silent mode set"
}
try {
  $osBitness = Get-ProcessorBits
  if ($osBitness -eq 64) {
    if ($unString=(Get-ItemProperty "$unpath\$packageName*" UninstallString).UninstallString) {}
    else { $unString=(Get-ItemProperty "$unPathx86\$packageName*" UninstallString).UninstallString }
  } else {
    $unString = (Get-ItemProperty "$unPath\$packageName*" UninstallString).UninstallString
  }
  # Detach all virtual disks
  $exeToRun = 'cmd.exe'
  $statements = '/c if exist "%SystemRoot%\system32\imdisk.exe" for /f %a in (''imdisk -l -n'') do @imdisk -D -u %~a'
  Start-ChocolateyProcessAsAdmin $statements $exeToRun
  Uninstall-ChocolateyPackage "$packageName" "$fileType" "$silentArgs" "$unString" -validExitCodes $validExitCodes
} catch {
  throw $_.Exception
}
