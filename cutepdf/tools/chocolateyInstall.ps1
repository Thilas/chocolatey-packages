$ErrorActionPreference = 'Stop';

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'cutepdf'
  fileType       = 'exe'
  url            = 'http://www.cutepdf.com/download/CuteWriter.exe'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  checksum       = '2D9E07F25358C9D2317BC639AFCDEDDB893D1FCFD43BB66FF372DBA11E169EE1'
  checksumType   = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
