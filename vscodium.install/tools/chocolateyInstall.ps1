$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. $toolsDir\helpers.ps1

# *** Automatically filled ***
$softwareName = 'VSCodium'
$version      = '1.79.1.23164'
# *** Automatically filled ***

if (!$Env:ChocolateyForce -and $version -eq (Get-UninstallRegistryKey $softwareName).DisplayVersion) {
    Write-Host "Version $version is already installed."
    return
}

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'vscodium.install'
    softwareName   = $softwareName
    fileType       = 'exe'
    url            = 'https://github.com/VSCodium/vscodium/releases/download/1.79.1.23164/VSCodiumSetup-ia32-1.79.1.23164.exe'
    url64bit       = 'https://github.com/VSCodium/vscodium/releases/download/1.79.1.23164/VSCodiumSetup-x64-1.79.1.23164.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = ''
    checksumType   = ''
    checksum64     = ''
    checksumType64 = ''
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
