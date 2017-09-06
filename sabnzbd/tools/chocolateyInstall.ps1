$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageName     = 'sabnzbd'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = 'https://github.com/sabnzbd/sabnzbd/releases/download/2.2.1/SABnzbd-2.2.1-win-setup.exe'
  silentArgs     = '/S'
  checksum       = 'dc19fac898e348edf8d87654f8a32432ee48096267e0c6d8f1cee339cc395065'
  checksumType   = 'sha256'
  validExitCodes = @(0)
}
$softwareName    = 'SABnzbd*'
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs

. (Join-Path $toolsDir 'Get-InstallPath.ps1')
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
