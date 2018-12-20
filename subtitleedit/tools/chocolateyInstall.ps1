$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
    packageName   = 'subtitleedit'
    url           = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/3.5.8/SubtitleEdit-3.5.8-Setup.zip'
    unzipLocation = $toolsDir
    checksum      = 'a696ed8852eda8c1c1e12c4437796d2bff8e7e83beb28670ba688d102c238c6c'
    checksumType  = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'subtitleedit'
    fileType       = 'exe'
    file           = "$toolsDir\SubtitleEdit-3.5.8-Setup.exe"
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyInstallPackage @packageArgs
