$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. "$toolsDir\Uninstall-ChocolateyShortcut.ps1"

$packageVersion = $Env:ChocolateyPackageVersion

$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) "Eclipse $packageVersion.lnk"
Uninstall-ChocolateyShortcut $shortcutPath -UnpinFromTaskbar

$logPath = Join-Path $Env:ChocolateyPackageFolder "eclipse.$packageVersion.txt"
$installationPath = Get-Content $logPath
Write-Verbose "Previous Installation Path: $installationPath"

Remove-Item -Path $installationPath -ErrorAction SilentlyContinue -Recurse -Force
