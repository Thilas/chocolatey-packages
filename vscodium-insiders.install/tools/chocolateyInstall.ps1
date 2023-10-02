$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. $toolsDir\helpers.ps1

# *** Automatically filled ***
$softwareName = 'VSCodium Insiders'
$version      = '1.83.0.23251'
# *** Automatically filled ***

if (!$Env:ChocolateyForce -and $version -eq (Get-UninstallRegistryKey $softwareName).DisplayVersion) {
    Write-Host "Version $version is already installed."
    return
}

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'vscodium-insiders.install'
    softwareName   = $softwareName
    fileType       = 'exe'
    url            = 'https://github.com/VSCodium/vscodium-insiders/releases/download/1.83.0.23251-insider/VSCodiumSetup-ia32-1.83.0.23251-insider.exe'
    url64bit       = 'https://github.com/VSCodium/vscodium-insiders/releases/download/1.83.0.23251-insider/VSCodiumSetup-x64-1.83.0.23251-insider.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '59094468a6675dc7786cb7b717a087652b2b46cb087645cd6ddb9e79fe635516'
    checksumType   = 'sha256'
    checksum64     = '6569fb95109cd940db89ecd52d450b9c53b4ab2817c304ebd144ebf7106a93b7'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

$pp = Get-PackageParameters
$mergeTasks = Get-MergeTasks $pp
$logPath = Get-PackageCacheLocation
$logPath = Join-Path $logPath 'install.log'
$packageArgs.silentArgs += ' /MERGETASKS="{0}" /LOG="{1}"' -f $mergeTasks, $logPath

Close-VSCodium

Install-ChocolateyPackage @packageArgs
