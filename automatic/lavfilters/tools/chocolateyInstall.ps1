$packageArgs = @{
  packageName    = 'lavfilters'
  fileType       = 'exe'
  url            = 'https://github.com/Nevcairiel/LAVFilters/releases/download/0.68.1/LAVFilters-0.68.1-Installer.exe'
  silentArgs     = '/SILENT'
  checksum       = '99fca55ad16c4388ee6222df475f44e7f3072f504e5cd6ff5c2c576a2dab8a3d'
  checksumType   = 'sha256'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
