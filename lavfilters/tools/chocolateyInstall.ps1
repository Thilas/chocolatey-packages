$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'lavfilters'
  fileType       = 'exe'
  url            = 'https://github.com/Nevcairiel/LAVFilters/releases/download/0.70.1/LAVFilters-0.70.1-Installer.exe'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  checksum       = '95ee5bb546b10a438a23b163e2f4577fb692f7fbc21669e2df107c0e26d7c572'
  checksumType   = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
