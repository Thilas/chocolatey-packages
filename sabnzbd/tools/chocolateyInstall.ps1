$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'sabnzbd'
    softwareName   = 'SABnzbd*'
    fileType       = 'exe'
    url            = 'https://github.com/sabnzbd/sabnzbd/releases/download/3.7.1RC1/SABnzbd-3.7.1RC1-win-setup.exe'
    silentArgs     = '/S'
    checksum       = '0bf3ee55e1064cbdda7574cf81bba349e075cd7d627862708a6fce2bea3ed087'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs

. "$toolsDir\Get-InstallPath.ps1"
$installPath = Get-InstallPath $packageArgs.packageName $packageArgs.softwareName

if ($installPath) {
    Write-Host "Installing service from $installPath..."
    Push-Location $installPath
    try {
        $iniPath = Join-Path $Env:LOCALAPPDATA 'sabnzbd\sabnzbd.ini'
        .\SABnzbd-console.exe -f `"$iniPath`" install
        Set-Service 'SABnzbd' -StartupType Automatic
        .\SABnzbd-console.exe start
    } finally {
        Pop-Location
    }
}
