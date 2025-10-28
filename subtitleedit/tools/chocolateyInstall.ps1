$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageCacheLocation = Get-PackageCacheLocation
. $toolsDir\helpers.ps1

# *** Automatically filled ***
$packageArgs = @{
    packageName   = 'subtitleedit'
    url           = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/4.0.14/SubtitleEdit-4.0.14-Setup.zip'
    unzipLocation = $packageCacheLocation
    checksum      = 'ea3cfe3af8c9eadf868c2030fcc95dcad927442413c7e4bfa6ca6bfa5c8b98fc'
    checksumType  = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'subtitleedit'
    softwareName   = 'Subtitle Edit*'
    fileType       = 'exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    validExitCodes = @(0)
}
# *** Automatically filled ***

$file = "$packageCacheLocation\*.{0}" -f $packageArgs.fileType | Get-Item | ForEach-Object FullName
if (!$file) {
    throw "Invalid zip file: installer is missing."
}
if ($file -is [array]) {
    throw "Invalid zip file: multiple installers found."
}

$pp = Get-PackageParameters
$mergeTasks = Get-MergeTasks $pp
$packageArgs.silentArgs += ' /MERGETASKS="{0}"' -f $mergeTasks

Install-ChocolateyInstallPackage @packageArgs -File $file

$logPath = Join-Path $toolsDir '*.zip.txt'
Remove-Item $logPath -Force -ErrorAction SilentlyContinue
Remove-Item $packageCacheLocation -Recurse -Force -ErrorAction SilentlyContinue
