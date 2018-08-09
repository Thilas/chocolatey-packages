$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageName  = 'sabnzbd'
$packageArgs  = @{
    packageName    = $packageName
    fileType       = 'exe'
    url            = 'https://github.com/sabnzbd/sabnzbd/releases/download/2.3.5RC1/SABnzbd-2.3.5RC1-win-setup.exe'
    silentArgs     = '/S'
    checksum       = '21ed9aa60c12b8c7080decd3e26844bf54a77325777ebf202b4ae38bbcaf4d92'
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
