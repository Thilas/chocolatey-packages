$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. $toolsDir\helpers.ps1

# *** Automatically filled ***
$softwareName = 'VSCodium Insiders'
$version      = '1.84.0.23283'
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
    url            = 'https://github.com/VSCodium/vscodium-insiders/releases/download/1.84.0.23283-insider/VSCodiumSetup-ia32-1.84.0.23283-insider.exe'
    url64bit       = 'https://github.com/VSCodium/vscodium-insiders/releases/download/1.84.0.23283-insider/VSCodiumSetup-x64-1.84.0.23283-insider.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '8bc9bd02a41ae6ecffd55b44f3540762baec3c767220c291e26e85e02a4e7384'
    checksumType   = 'sha256'
    checksum64     = '67c11500792f631e3d9e5b1e7a9cbd6c604cca94b133fb5f7138dcb3dccfdf37'
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
