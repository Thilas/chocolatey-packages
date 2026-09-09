$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. $toolsDir\helpers.ps1

# *** Automatically filled ***
$softwareName = 'VSCodium'
$version      = '1.135.6055'
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
    url64bit       = 'https://github.com/VSCodium/vscodium/releases/download/1.135.06055/VSCodiumSetup-x64-1.135.06055.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum64     = 'c4b1dea94341c8f36a18afa404fe8552854beb7ab8f14b397235a65a23154113'
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
