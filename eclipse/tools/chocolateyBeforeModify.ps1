$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. "$toolsDir\Uninstall-ChocolateyShortcut.ps1"

$packageVersion = $Env:ChocolateyPackageVersion

$shortcutName = "Eclipse $packageVersion.lnk"
$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) $shortcutName
if (Test-Path $shortcutPath) {
    Uninstall-ChocolateyShortcut $shortcutPath -UnpinFromTaskbar
}
$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonDesktopDirectory)) $shortcutName
if (Test-Path $shortcutPath) {
    Uninstall-ChocolateyShortcut $shortcutPath
}

$logPath = Join-Path $Env:ChocolateyPackageFolder "eclipse.$packageVersion.txt"
$installationPath = Get-Content $logPath
Write-Verbose "Previous Installation Path: $installationPath"
Remove-Item -Path $logPath -ErrorAction SilentlyContinue

Remove-Item -Path $installationPath -ErrorAction SilentlyContinue -Recurse -Force

$logPath = Join-Path $Env:ChocolateyPackageFolder '*.zip.txt'
Remove-Item -Path $logPath -ErrorAction SilentlyContinue
