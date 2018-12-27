$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. $toolsDir\helpers.ps1

# *** Automatically filled ***
$softwareName = ''
$version      = ''
# *** Automatically filled ***

if ($version -eq (Get-UninstallRegistryKey $softwareName).DisplayVersion) {
    Write-Host "Version $version is already installed."
    return
  }
  
# *** Automatically filled ***
$packageArgs = @{
    softwareName   = $softwareName
    packageName    = ''
    fileType       = ''
    url            = ''
    url64bit       = ''
    silentArgs     = ''
    checksum       = ''
    checksumType   = ''
    checksum64     = ''
    checksumType64 = ''
    validExitCodes = @()
}
# *** Automatically filled ***

$pp = Get-PackageParameters
$mergeTasks = Get-MergeTasks $pp
$logPath = Get-PackageCacheLocation
$logPath = Join-Path $logPath 'install.log'
$packageArgs.silentArgs += ' /MERGETASKS="{0}" /LOG="{1}"' -f $mergeTasks, $logPath

Close-VSCode

Install-ChocolateyPackage @packageArgs
