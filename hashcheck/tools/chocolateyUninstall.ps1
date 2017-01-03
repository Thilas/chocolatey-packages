$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageName    = 'hashcheck'
$validExitCodes = @(0)
# *** Automatically filled ***

$file = 'regsvr32.exe'

$dll = Join-Path $env:SystemRoot 'SysWOW64\ShellExt\HashCheck.dll'
if (Test-Path $dll) {
  $exeToRun = Join-Path $env:SystemRoot 'SysWOW64\cmd.exe'
  $statements = "/s /c ""$file /s /u /i /n $dll"""
  Start-ChocolateyProcessAsAdmin -Statements $statements -ExeToRun $exeToRun -ValidExitCodes $validExitCodes
}

$dll = Join-Path $env:SystemRoot 'System32\ShellExt\HashCheck.dll'
if (Test-Path $dll) {
  $fileType   = 'exe'
  $silentArgs = "/s /u /i /n $dll"
  Uninstall-ChocolateyPackage -PackageName $packageName -FileType $fileType -SilentArgs $silentArgs -ValidExitCodes $validExitCodes -File $file
} else {
  Write-Host "$packageName has already been uninstalled by other means."
}
