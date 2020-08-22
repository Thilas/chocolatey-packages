$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. $toolsDir\helpers.ps1

# *** Automatically filled ***
$softwareName = 'VSCodium'
$version      = '1.48.1'
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
    url            = 'https://github.com/VSCodium/vscodium/releases/download/1.48.1/VSCodiumSetup-ia32-1.48.1.exe'
    url64bit       = 'https://github.com/VSCodium/vscodium/releases/download/1.48.1/VSCodiumSetup-x64-1.48.1.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '96a96de07e41301e914792a402c205bf4b81f4c595b0ac76b57dd8aed7d99aa1'
    checksumType   = 'sha256'
    checksum64     = '8939b9b384ef420cad1ab7670cd2139e3c6b2e4ad263800ed0584903787e3bf7'
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
