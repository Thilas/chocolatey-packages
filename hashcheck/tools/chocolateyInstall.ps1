$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'hashcheck'
    fileType       = 'exe'
    url            = 'https://github.com/gurnec/HashCheck/releases/download/v2.4.0.24-beta/HashCheckSetup-v2.4.0.24-beta.exe'
    silentArgs     = '/S'
    checksum       = '47850f3a06d76f788845e8dfde299c92a6eb340b3ef635d376e82ec7f4290b19'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
