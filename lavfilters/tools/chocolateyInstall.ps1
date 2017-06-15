$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'lavfilters'
  fileType       = 'exe'
  url            = 'https://github.com/Nevcairiel/LAVFilters/releases/download/0.70/LAVFilters-0.70-Installer.exe'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  checksum       = '5b6a46ccf52025155cd5dab9906e8785a125e534d609c14168edb45f20416bc2'
  checksumType   = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
