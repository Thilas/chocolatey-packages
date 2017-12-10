$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageName     = 'sabnzbd'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = 'https://github.com/sabnzbd/sabnzbd/releases/download/2.3.2RC2/SABnzbd-2.3.2RC2-win-setup.exe'
  silentArgs     = '/S'
  checksum       = '089d434ea94cc4c2ba537b706a5bf7e49c66a4c3b1669538b007e6886a63b42d'
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
