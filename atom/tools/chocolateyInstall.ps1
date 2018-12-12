$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.34.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.34.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = 'e1b69fc5da49b6eb2d2f149d70b9d5b8d2ba968a5e140ece47b76b98d60b5f4b'
    checksumType   = 'sha256'
    checksum64     = '1ee4b5a3877afc3248f0e6b9f545652ef74b939d57ae4c23aa5910b6c9c73163'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
