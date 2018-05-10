$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageName  = 'sabnzbd'
$packageArgs  = @{
    packageName    = $packageName
    fileType       = 'exe'
    url            = 'https://github.com/sabnzbd/sabnzbd/releases/download/2.3.3/SABnzbd-2.3.3-win-setup.exe'
    silentArgs     = '/S'
    checksum       = '7b3d174b12001f1b5b2bdfaac797aea028b514f87a41535675e6f4cf07c59b80'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
$softwareName = 'SABnzbd*'
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs

. "$toolsDir\Get-InstallPath.ps1"
$installPath = Get-InstallPath $packageName $softwareName

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
