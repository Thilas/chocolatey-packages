$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. $toolsDir\helpers.ps1

# *** Automatically filled ***
$softwareName = 'VSCodium'
$version      = '1.32.3'
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
    # url            = ''
    url64bit       = 'https://github.com/VSCodium/vscodium/releases/download/1.32.3/VSCodiumSetup-x64-1.32.3.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    # checksum       = ''
    # checksumType   = ''
    checksum64     = 'ee799b3e739fb9dab3927e6c2ab5d8ccaf1e681a2c618bd7a8884a4970d5241d'
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
