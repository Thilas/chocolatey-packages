# stop on all errors
$ErrorActionPreference = 'Stop';
 
$packageName = '{{PackageName}}'

$installerType = 'exe'
$silentArgs = '/s /u /i /n C:\Windows\System32\ShellExt\HashCheck.dll'
$validExitCodes = @(0)

if (Test-Path 'C:\Windows\SysWOW64\ShellExt\HashCheck.dll') {
  $exeToRun = 'C:\Windows\SysWOW64\cmd.exe'
  $statements = "/s /c ""regsvr32.exe $silentArgs"""
  Start-ChocolateyProcessAsAdmin -Statements $statements -ExeToRun $exeToRun -ValidExitCodes $validExitCodes
}

if (Test-Path 'C:\Windows\system32\ShellExt\HashCheck.dll') {
  Uninstall-ChocolateyPackage -PackageName $packageName -FileType $installerType -SilentArgs $silentArgs -File 'regsvr32.exe' -ValidExitCodes $validExitCodes
} else {
  Write-Host "$packageName has already been uninstalled by other means."
}
