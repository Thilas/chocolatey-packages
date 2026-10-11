$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. $toolsDir\helpers.ps1

# *** Automatically filled ***
$softwareName = 'VSCodium Insiders'
$version      = '1.140.6829'
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
    url64bit       = 'https://github.com/VSCodium/vscodium-insiders/releases/download/1.140.06829-insider/VSCodiumSetup-x64-1.140.06829-insider.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum64     = '68d85738ad0682105d635ae4107043e74fdf42a2f6263a23900e72d857d0f596'
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
