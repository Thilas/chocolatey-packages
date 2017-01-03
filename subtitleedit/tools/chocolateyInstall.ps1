$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'subtitleedit'
  url            = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/3.5.1/SubtitleEdit-3.5.1-Setup.zip'
  unzipLocation  = $toolsDir
  checksum       = '1d7969005b70df63f889d1588bf4c2adea97207a4a297f43d74c1b5e08c226f3'
  checksumType   = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'subtitleedit'
  fileType       = 'exe'
  file           = Join-Path $toolsDir 'SubtitleEdit-3.5.1-Setup.exe'
  silentArgs     = '/VERYSILENT'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyInstallPackage @packageArgs
