$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageCacheLocation = Get-PackageCacheLocation

# *** Automatically filled ***
$packageArgs = @{
    packageName   = 'subtitleedit'
    url           = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/3.6.7/SubtitleEdit-3.6.7-Setup.zip'
    unzipLocation = $packageCacheLocation
    checksum      = '6558c17d4281b806d32aba94921066269b5df441c0517e881ae45af26e66d338'
    checksumType  = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'subtitleedit'
    softwareName   = 'Subtitle Edit *'
    fileType       = 'exe'
    file           = "$packageCacheLocation\SubtitleEdit-3.6.7-Setup.exe"
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyInstallPackage @packageArgs

$logPath = Join-Path $toolsDir '*.zip.txt'
Remove-Item $logPath, $packageArgs.file -Force -ErrorAction SilentlyContinue
