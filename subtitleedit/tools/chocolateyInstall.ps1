$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageCacheLocation = Get-PackageCacheLocation

# *** Automatically filled ***
$packageArgs = @{
    packageName   = 'subtitleedit'
    url           = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/3.6.8/SubtitleEdit-3.6.8-Setup.zip'
    unzipLocation = $packageCacheLocation
    checksum      = 'b3bb688b94ce013989711e986dadb4f15abeba9affe0656df7f186115b5ed6b4'
    checksumType  = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'subtitleedit'
    softwareName   = 'Subtitle Edit *'
    fileType       = 'exe'
    file           = "$packageCacheLocation\SubtitleEdit-3.6.8-Setup.exe"
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyInstallPackage @packageArgs

$logPath = Join-Path $toolsDir '*.zip.txt'
Remove-Item $logPath, $packageArgs.file -Force -ErrorAction SilentlyContinue
