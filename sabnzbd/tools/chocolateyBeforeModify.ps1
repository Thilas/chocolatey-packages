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
    Push-Location $installPath
    try {
        'SABnzbd-console.exe', 'SABnzbd-service.exe', 'SABnzbd-helper.exe' `
        | Where-Object { Test-Path $_ } `
        | ForEach-Object {
            & ".\$_" stop
            & ".\$_" remove
        }
    } finally {
        Pop-Location
    }
}
