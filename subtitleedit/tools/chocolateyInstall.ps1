$ErrorActionPreference = 'Stop'

$packageCacheLocation = Get-PackageCacheLocation

# *** Automatically filled ***
$packageArgs = @{
    packageName   = 'subtitleedit'
    url           = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/3.5.17/SubtitleEdit-3.5.17-Setup.zip'
    unzipLocation = $packageCacheLocation
    checksum      = '4c4cd3a6da19bd0f7216dd73df22263bf59111a87a98bc526390459e4f48f98c'
    checksumType  = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'subtitleedit'
    softwareName   = 'Subtitle Edit *'
    fileType       = 'exe'
    file           = "$packageCacheLocation\SubtitleEdit-3.5.17-Setup.exe"
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyInstallPackage @packageArgs

$logPath = Join-Path $Env:ChocolateyPackageFolder '*.zip.txt'
Remove-Item $logPath, $packageArgs.file -Force -ErrorAction SilentlyContinue
