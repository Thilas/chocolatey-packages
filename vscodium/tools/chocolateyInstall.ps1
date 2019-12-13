$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. $toolsDir\helpers.ps1

# *** Automatically filled ***
$softwareName = 'VSCodium'
$version      = '1.41.0'
# *** Automatically filled ***

if ($version -eq (Get-UninstallRegistryKey $softwareName).DisplayVersion) {
    Write-Host "Version $version is already installed."
    return
}
  
# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'vscodium'
    softwareName   = $softwareName
    fileType       = 'exe'
    url            = 'https://github.com/VSCodium/vscodium/releases/download/1.41.0/VSCodiumSetup-ia32-1.41.0.exe'
    url64bit       = 'https://github.com/VSCodium/vscodium/releases/download/1.41.0/VSCodiumSetup-x64-1.41.0.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '30a1510b0bb852c8978f8205d385f274314781076fe2c327b100068da593e8b6'
    checksumType   = 'sha256'
    checksum64     = '9bd1dcbd74177d453af0e9d926f96b49717610030fd1beb1e5858b1190ce69e7'
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
