$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$logPath = Join-Path $toolsDir '*.zip.txt'
Remove-Item -Path $logPath -ErrorAction SilentlyContinue

# Clean a previous install
$logPath = Join-Path $toolsDir 'vscodium.txt'
Write-Verbose "Reading Installation Path from $logPath"
$installationPath = Get-Content $logPath
Write-Verbose "Previous Installation Path: $installationPath"
if (Test-Path $installationPath -ErrorAction SilentlyContinue) {
    Get-ChildItem -Path $installationPath -Exclude 'data' -ErrorAction SilentlyContinue `
    | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
} else {
    Write-Warning "Installation Path missing or not found: $installationPath"
}
