$ErrorActionPreference = 'Stop'

$logPath = Join-Path $Env:ChocolateyPackageFolder '*.zip.txt'
Remove-Item -Path $logPath -ErrorAction SilentlyContinue

# Clean a previous install
$logPath = Join-Path $Env:ChocolateyPackageFolder 'atom.txt'
$installationPath = Get-Content $logPath
Write-Verbose "Previous Installation Path: $installationPath"
Get-ChildItem -Path $installationPath -Exclude '.atom' -ErrorAction SilentlyContinue `
| Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
