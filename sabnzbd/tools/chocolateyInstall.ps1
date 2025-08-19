$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'sabnzbd'
    softwareName   = 'SABnzbd*'
    fileType       = 'exe'
    url            = 'https://github.com/sabnzbd/sabnzbd/releases/download/4.5.3RC1/SABnzbd-4.5.3RC1-win-setup.exe'
    silentArgs     = '/S'
    checksum       = '4ec3ad6ee3fee0dbb12e0685a5ccf9ff7b2f7b1be83c41bece3024bf4b8cdbb2'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs

. "$toolsDir\Get-InstallPath.ps1"
$installPath = Get-InstallPath $packageArgs.packageName $packageArgs.softwareName

if ($installPath) {
    Write-Host "Installing service from $installPath..."

    # Copy some missing files from pywin32_system32 to avoid a scary warning while installing service
    Join-Path $installPath 'pywin32_system32' `
    | Get-ChildItem -File `
    | Where-Object Name -Match '^(python|pywintypes)\d+\.dll$' `
    | Where-Object { !(Join-Path $installPath $_.Name | Test-Path) } `
    | Copy-Item -Destination $installPath

    $exePath = Join-Path $installPath 'SABnzbd-console.exe'
    $iniPath = Join-Path $Env:LOCALAPPDATA 'sabnzbd\sabnzbd.ini'
    Start-ChocolateyProcessAsAdmin -WorkingDirectory $installPath -ExeToRun $exePath -Statements "-f `"$iniPath`" install" | Out-Null
    Set-Service 'SABnzbd' -StartupType Automatic
    Start-ChocolateyProcessAsAdmin -WorkingDirectory $installPath -ExeToRun $exePath -Statements 'start' | Out-Null
}
