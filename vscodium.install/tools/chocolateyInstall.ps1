$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. $toolsDir\helpers.ps1

# *** Automatically filled ***
$softwareName = 'VSCodium'
$version      = '1.52.0'
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
    url            = 'https://github.com/VSCodium/vscodium/releases/download/1.52.0/VSCodiumSetup-ia32-1.52.0.exe'
    url64bit       = 'https://github.com/VSCodium/vscodium/releases/download/1.52.0/VSCodiumSetup-x64-1.52.0.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '76ae1a481a63df7fc48f5b196928872b49de069b3a40ad4a33e32f767f689ed4'
    checksumType   = 'sha256'
    checksum64     = 'af47eebc14bf8e7ddce0fe1a1a2f371660a106522fec4d2183f65eb0dbf5ddd0'
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
