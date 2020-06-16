$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
    packageName   = 'subtitleedit'
    url           = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/3.5.16/SubtitleEdit-3.5.16-Setup.zip'
    unzipLocation = $toolsDir
    checksum      = '5dfc6af78bf6f3d990416dab2b1d2d1bc1ee80f3e892d00463bfae31b6feb6e4'
    checksumType  = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'subtitleedit'
    softwareName   = 'Subtitle Edit *'
    fileType       = 'exe'
    file           = "$toolsDir\SubtitleEdit-3.5.16-Setup.exe"
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyInstallPackage @packageArgs

$file = $packageArgs.file
Remove-Item $file, "$file.ignore" -Force -ErrorAction SilentlyContinue
