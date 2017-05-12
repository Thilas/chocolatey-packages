$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'subtitleedit'
  url            = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/3.5.3/SubtitleEdit-3.5.3-Setup.zip'
  unzipLocation  = $toolsDir
  checksum       = 'ed633458b5a040f0485d6f5758dba0de847d577487370dfeae9fa6c47a6f73f8'
  checksumType   = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'subtitleedit'
  fileType       = 'exe'
  file           = Join-Path $toolsDir 'SubtitleEdit-3.5.3-Setup.exe'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyInstallPackage @packageArgs
