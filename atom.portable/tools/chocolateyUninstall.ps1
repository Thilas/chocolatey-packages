$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$shortcutName = 'Atom.lnk'
$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) $shortcutName
Remove-Item $shortcutPath -ErrorAction SilentlyContinue -Force

$logPath = Join-Path $toolsDir 'atom.txt'
Write-Verbose "Reading Installation Path from $logPath"
$installationPath = Get-Content $logPath
Write-Verbose "Previous Installation Path: $installationPath"

Uninstall-BinFile -Name 'atom'

if (Test-Path $installationPath -ErrorAction SilentlyContinue) {
    Remove-Item -Path $installationPath -ErrorAction SilentlyContinue -Recurse -Force
} else {
    Write-Warning "Installation Path missing or not found: $installationPath"
}
