$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. $toolsDir\helpers.ps1

# *** Automatically filled ***
$softwareName = 'VSCodium'
$version      = '1.34.0'
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
    url            = 'https://github.com/VSCodium/vscodium/releases/download/1.34.0/VSCodiumSetup-ia32-1.34.0.exe'
    url64bit       = 'https://github.com/VSCodium/vscodium/releases/download/1.34.0/VSCodiumSetup-x64-1.34.0.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '134ebb0ef43a2d285e49004acfd92567ff5f54d5faa982f4626f429048f2d8df'
    checksumType   = 'sha256'
    checksum64     = 'ba7b26b497d75f0a399fecebecc799bbabbf762894ea9011845be3c78eeb3cc7'
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
