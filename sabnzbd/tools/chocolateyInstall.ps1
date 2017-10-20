$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageName     = 'sabnzbd'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = 'https://github.com/sabnzbd/sabnzbd/releases/download/2.3.1RC2/SABnzbd-2.3.1RC2-win-setup.exe'
  silentArgs     = '/S'
  checksum       = '008de489b95a1a42360bee049925bff8721a53f544c73dcffd731e3a3a0db854'
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
