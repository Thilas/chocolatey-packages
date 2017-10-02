$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'subtitleedit'
  url            = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/3.5.4/SubtitleEdit-3.5.4-Setup.zip'
  unzipLocation  = $toolsDir
  checksum       = 'f8057d7fa7148b2b19e49456052295e1a54da94a0e04040ad340a36dfee4bec5'
  checksumType   = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'subtitleedit'
  fileType       = 'exe'
  file           = Join-Path $toolsDir 'SubtitleEdit-3.5.4-Setup.exe'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyInstallPackage @packageArgs
