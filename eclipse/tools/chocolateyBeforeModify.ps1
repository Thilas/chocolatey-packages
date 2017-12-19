$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. "$toolsDir\Uninstall-ChocolateyShortcut.ps1"

$packageVersion = $Env:ChocolateyPackageVersion

$shortcutName = "Eclipse $packageVersion.lnk"
$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) $shortcutName
If (Test-Path $shortcutPath) {
  Uninstall-ChocolateyShortcut $shortcutPath -UnpinFromTaskbar
}
$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonDesktopDirectory)) $shortcutName
If (Test-Path $shortcutPath) {
  Uninstall-ChocolateyShortcut $shortcutPath
}

$logPath = Join-Path $Env:ChocolateyPackageFolder "eclipse.$packageVersion.txt"
$installationPath = Get-Content $logPath
Write-Verbose "Previous Installation Path: $installationPath"

Remove-Item -Path $installationPath -ErrorAction SilentlyContinue -Recurse -Force
