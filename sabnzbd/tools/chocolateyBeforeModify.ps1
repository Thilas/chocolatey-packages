$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageName  = 'sabnzbd'
$softwareName = 'SABnzbd*'
# *** Automatically filled ***

. "$toolsDir\Get-InstallPath.ps1"
$installPath = Get-InstallPath $packageName $softwareName

if ($installPath) {
    Write-Host "Stopping services..."
    Stop-Service '*' -Include 'SABnzbd', 'SABhelper' -Force

    Write-Host 'Uninstalling services...'
    'SABnzbd-console.exe', 'SABnzbd-service.exe', 'SABnzbd-helper.exe' `
    | ForEach-Object { Join-Path $installPath $_ } `
    | Where-Object { Test-Path $_ } `
    | ForEach-Object { & $_ remove }
}
