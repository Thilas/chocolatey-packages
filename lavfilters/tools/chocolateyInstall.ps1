$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'lavfilters'
  fileType       = 'exe'
  url            = 'https://github.com/Nevcairiel/LAVFilters/releases/download/0.71/LAVFilters-0.71-Installer.exe'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  checksum       = 'fde31a07d541e06a7b24c6eac8edcd093b3674794c5f0b0baf1f0654288008b8'
  checksumType   = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
