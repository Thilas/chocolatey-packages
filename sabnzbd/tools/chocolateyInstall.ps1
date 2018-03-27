$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageName  = 'sabnzbd'
$packageArgs  = @{
    packageName    = $packageName
    fileType       = 'exe'
    url            = 'https://github.com/sabnzbd/sabnzbd/releases/download/2.3.3RC1/SABnzbd-2.3.3RC1-win-setup.exe'
    silentArgs     = '/S'
    checksum       = 'b4b28a14ced7db044419b00d594a2ab31393307cecf057bd59c3e1e93466357f'
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

    Pop-Location
}

Write-Host 'Starting services...'
Start-Service '*' -Include 'SABnzbd', 'SABhelper'
