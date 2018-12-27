$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. $toolsDir\helpers.ps1

# *** Automatically filled ***
$softwareName = 'VSCodium'
$version      = '1.30.1'
# *** Automatically filled ***

if ($version -eq (Get-UninstallRegistryKey $softwareName).DisplayVersion) {
    Write-Host "Version $version is already installed."
    return
  }
  
# *** Automatically filled ***
$packageArgs = @{
    softwareName   = $softwareName
    packageName    = 'vscodium'
    fileType       = 'exe'
    url            = 'https://github.com/VSCodium/vscodium/releases/download/1.30.1/VSCodiumSetup-x64-1.30.1.exe'
    url64bit       = 'https://github.com/VSCodium/vscodium/releases/download/1.30.1/VSCodiumSetup-x64-1.30.1.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '624d751d481f1e7bdc816ded3f5f4f9c54bd848b5766b2af73fe290c2008e530'
    checksumType   = 'sha256'
    checksum64     = '624d751d481f1e7bdc816ded3f5f4f9c54bd848b5766b2af73fe290c2008e530'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

$pp = Get-PackageParameters
$mergeTasks = Get-MergeTasks $pp
$logPath = Get-PackageCacheLocation
$logPath = Join-Path $logPath 'install.log'
$packageArgs.silentArgs += ' /MERGETASKS="{0}" /LOG="{1}"' -f $mergeTasks, $logPath

Close-VSCode

Install-ChocolateyPackage @packageArgs
