$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. $toolsDir\helpers.ps1

# *** Automatically filled ***
$softwareName = 'VSCodium'
$version      = '1.37.0'
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
    url            = 'https://github.com/VSCodium/vscodium/releases/download/1.37.0/VSCodiumSetup-ia32-1.37.0.exe'
    url64bit       = 'https://github.com/VSCodium/vscodium/releases/download/1.37.0/VSCodiumSetup-x64-1.37.0.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '4ca9a9f861868515c9aa5a8a3a9e6c797a2710994097cac4e2e0b82afd8a1fee'
    checksumType   = 'sha256'
    checksum64     = 'c51fb35a8768704e9a4724ddedb9eb97dde2846661765ca26f8710d5c964e9d8'
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
