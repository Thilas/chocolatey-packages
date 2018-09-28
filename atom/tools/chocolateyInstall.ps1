$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.32.0-beta1/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.32.0-beta1/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '7dc1cea2a1ec2b1b9116c25a7dadb904d12b1ecbda1266690dd9f6836b906dc7'
    checksumType   = 'sha256'
    checksum64     = '59b28e3a39eb541f0aa8e75af769348b0e7505e26438dec8ab994eb03afc358e'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
