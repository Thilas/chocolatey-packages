$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. $toolsDir\helpers.ps1

# *** Automatically filled ***
$softwareName = 'VSCodium'
$version      = '1.30.2'
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
    url            = 'https://github.com/VSCodium/vscodium/releases/download/1.30.2/VSCodiumSetup-x64-1.30.2.exe'
    url64bit       = 'https://github.com/VSCodium/vscodium/releases/download/1.30.2/VSCodiumSetup-x64-1.30.2.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '5144a63e7433a2525f27084e50c8b4395475083bd88db7afb613fbd202f895ce'
    checksumType   = 'sha256'
    checksum64     = '5144a63e7433a2525f27084e50c8b4395475083bd88db7afb613fbd202f895ce'
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
