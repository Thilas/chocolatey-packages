$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. $toolsDir\helpers.ps1

# *** Automatically filled ***
$softwareName = 'VSCodium'
$version      = '1.45.0'
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
    url            = 'https://github.com/VSCodium/vscodium/releases/download/1.45.0/VSCodiumSetup-ia32-1.45.0.exe'
    url64bit       = 'https://github.com/VSCodium/vscodium/releases/download/1.45.0/VSCodiumSetup-x64-1.45.0.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = 'b634eca440c3bafc5ee915ce3fbb9bc1372148ec04a3e0917c6b22d61f8cf7d8'
    checksumType   = 'sha256'
    checksum64     = '74f304ddb3980256c6f0b34f5d7cb206f369d1c892413cc71826356ea21e49ce'
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
