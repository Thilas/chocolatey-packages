$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageName  = 'sabnzbd'
$softwareName = 'SABnzbd*'
# *** Automatically filled ***

Write-Host 'Stopping services if they''re running...'
Stop-Service '*' -Include 'SABnzbd', 'SABhelper' -Force

. "$toolsDir\Get-InstallPath.ps1"
$installPath = Get-InstallPath $packageName $softwareName

if ($installPath) {
    Push-Location $installPath

    Write-Host 'Uninstalling services...'

    $service = 'SABnzbd-service.exe'
    if (Test-Path $service) { & ".\$service" remove }

    $helper = 'SABnzbd-helper.exe'
    if (Test-Path $helper) { & ".\$helper" remove }

    Pop-Location
}
