$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'sabnzbd'
    softwareName   = 'SABnzbd*'
    fileType       = 'exe'
    url            = 'https://github.com/sabnzbd/sabnzbd/releases/download/4.0.2/SABnzbd-4.0.2-win-setup.exe'
    silentArgs     = '/S'
    checksum       = '89f1f7855d9712363d29b1ce476b2f628df7beaa0a9c9a67c0976634236387b8'
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
