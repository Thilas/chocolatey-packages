$packageArgs = @{
  packageName    = 'hashcheck'
  fileType       = 'exe'
  url            = 'https://github.com/gurnec/HashCheck/releases/download/v2.3.2/HashCheckSetup-v2.3.2.exe'
  silentArgs     = '/S'
  checksum       = '86c23c06f7d4ec49b298469bc3e7bbd8aa1a46f0fc988eb49905e9eae07808da'
  checksumType   = 'sha256'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
