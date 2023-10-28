$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageName  = 'sabnzbd'
$softwareName = 'SABnzbd*'
# *** Automatically filled ***

. "$toolsDir\Get-InstallPath.ps1"
$installPath = Get-InstallPath $packageName $softwareName

if ($installPath) {
    Write-Host "Uninstalling service from $installPath..."
    'SABnzbd-console.exe', 'SABnzbd-service.exe', 'SABnzbd-helper.exe' `
    | ForEach-Object { Join-Path $installPath $_ } `
    | Where-Object { Test-Path $_ } `
    | ForEach-Object {
        Start-ChocolateyProcessAsAdmin -WorkingDirectory $installPath -ExeToRun $_ -Statements 'stop' | Out-Null
        Start-ChocolateyProcessAsAdmin -WorkingDirectory $installPath -ExeToRun $_ -Statements 'remove' | Out-Null
    }
}
