$packageArgs = @{
  packageName    = 'lavfilters'
  fileType       = 'exe'
  url            = 'https://github.com/Nevcairiel/LAVFilters/releases/download/0.69/LAVFilters-0.69-Installer.exe'
  silentArgs     = '/SILENT'
  checksum       = 'ca247ddea684e5000647b20cfeb0e91eb83b91faed14e15add07750f515369a6'
  checksumType   = 'sha256'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
