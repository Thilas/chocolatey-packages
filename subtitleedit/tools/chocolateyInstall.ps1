$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
    packageName   = 'subtitleedit'
    url           = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/3.5.15/SubtitleEdit-3.5.15-Setup.zip'
    unzipLocation = $toolsDir
    checksum      = '41e704fb5347194c137723274f2501af04ce5147ee86db782134c8e4dcd0c332'
    checksumType  = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'subtitleedit'
    softwareName   = 'Subtitle Edit *'
    fileType       = 'exe'
    file           = "$toolsDir\SubtitleEdit-3.5.15-Setup.exe"
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyInstallPackage @packageArgs

$file = $packageArgs.file
Remove-Item $file, "$file.ignore" -Force -ErrorAction SilentlyContinue
