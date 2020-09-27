$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'sabnzbd'
    softwareName   = 'SABnzbd*'
    fileType       = 'exe'
    url            = 'https://github.com/sabnzbd/sabnzbd/releases/download/3.1.0RC2/SABnzbd-3.1.0RC2-win-setup.exe'
    silentArgs     = '/S'
    checksum       = '33225f51a69415c8464cb9b892ada235a03e57c84e077f9115d4dc946919ed44'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs

. "$toolsDir\Get-InstallPath.ps1"
$installPath = Get-InstallPath $packageArgs.packageName $packageArgs.softwareName

if ($installPath) {
    Push-Location $installPath
    try {
        Write-Host 'Installing services...'

        $helper = 'SABnzbd-helper.exe'
        if (Test-Path $helper) {
            & ".\$helper" install
            Set-Service 'SABhelper' -StartupType Automatic
        }

        $service = 'SABnzbd-service.exe'
        if (Test-Path $service) {
            $iniPath = Join-Path $Env:LOCALAPPDATA 'sabnzbd\sabnzbd.ini'
            & ".\$service" -f $iniPath install
            Set-Service 'SABnzbd' -StartupType Automatic
        }
    } finally {
        Pop-Location
    }
}

Write-Host 'Starting services...'
Start-Service '*' -Include 'SABnzbd', 'SABhelper'
