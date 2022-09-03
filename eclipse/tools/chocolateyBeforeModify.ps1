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

$logPath = Join-Path $toolsDir "eclipse.$packageVersion.txt"
Write-Verbose "Reading Installation Path from $logPath"
$installationPath = Get-Content $logPath
Write-Verbose "Previous Installation Path: $installationPath"
Remove-Item -Path $logPath -ErrorAction SilentlyContinue

if (Test-Path $installationPath -ErrorAction SilentlyContinue) {
    Remove-Item -Path $installationPath -ErrorAction SilentlyContinue -Recurse -Force
} else {
    Write-Warning "Installation Path missing or not found: $installationPath"
}

$logPath = Join-Path $toolsDir '*.zip.txt'
Remove-Item -Path $logPath -ErrorAction SilentlyContinue
