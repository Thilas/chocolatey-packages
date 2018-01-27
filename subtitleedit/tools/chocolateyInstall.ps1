$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'subtitleedit'
  url            = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/3.5.5/SubtitleEdit-3.5.5-Setup.zip'
  unzipLocation  = $toolsDir
  checksum       = '992ee1c00ddb4b2e191b70af89b0303a3c4481e6338def64c6a7a5b3123eed4d'
  checksumType   = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'subtitleedit'
  fileType       = 'exe'
  file           = Join-Path $toolsDir 'SubtitleEdit-3.5.5-Setup.exe'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyInstallPackage @packageArgs
