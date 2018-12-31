$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'imdisk'
    softwareName   = 'ImDisk *'
    fileType       = 'exe'
    silentArgs     = '-y'
    validExitCodes = @(0)
}
# *** Automatically filled ***

$packageArgs.file = Get-Item ("$toolsDir\*.{0}" -f $packageArgs.fileType)

$installOverride = $env:chocolateyInstallOverride
if (!$installOverride) {
    $env:IMDISK_SILENT_SETUP = 1
    Write-Host "Silent mode set"
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $packageArgs.file -ErrorAction SilentlyContinue
