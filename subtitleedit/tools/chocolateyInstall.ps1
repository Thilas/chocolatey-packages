$ErrorActionPreference = 'Stop'

$packageCacheLocation = Get-PackageCacheLocation

# *** Automatically filled ***
$packageArgs = @{
    packageName   = 'subtitleedit'
    url           = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/3.6.6/SubtitleEdit-3.6.6-Setup.zip'
    unzipLocation = $packageCacheLocation
    checksum      = 'cb6f9c84388c24cf5d962a856a9e0266d90f609c4ebb24df060843d0a233b862'
    checksumType  = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'subtitleedit'
    softwareName   = 'Subtitle Edit *'
    fileType       = 'exe'
    file           = "$packageCacheLocation\SubtitleEdit-3.6.6-Setup.exe"
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyInstallPackage @packageArgs

$logPath = Join-Path $Env:ChocolateyPackageFolder '*.zip.txt'
Remove-Item $logPath, $packageArgs.file -Force -ErrorAction SilentlyContinue
