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

$Env:IMDISK_SILENT_SETUP = 1

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $packageArgs.file -ErrorAction SilentlyContinue
