$ErrorActionPreference = 'Stop'

$packageCacheLocation = Get-PackageCacheLocation

# *** Automatically filled ***
$packageArgs = @{
    packageName   = 'subtitleedit'
    url           = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/3.6.4/SubtitleEdit-3.6.4-Setup.zip'
    unzipLocation = $packageCacheLocation
    checksum      = 'df1e922b58d6a39515e4384475633e72e4d33a1c328bc99291c2c4f6fef8462a'
    checksumType  = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'subtitleedit'
    softwareName   = 'Subtitle Edit *'
    fileType       = 'exe'
    file           = "$packageCacheLocation\SubtitleEdit-3.6.4-Setup.exe"
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyInstallPackage @packageArgs

$logPath = Join-Path $Env:ChocolateyPackageFolder '*.zip.txt'
Remove-Item $logPath, $packageArgs.file -Force -ErrorAction SilentlyContinue
