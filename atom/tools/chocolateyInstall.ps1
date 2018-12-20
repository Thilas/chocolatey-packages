$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.34.0-beta1/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.34.0-beta1/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '53d4f5fd85737857e9c79fae1727aa81a5f3a7af10b7666b84718ad4b22bd530'
    checksumType   = 'sha256'
    checksum64     = 'd54962316223707b1d225f6d9690137a572d71fcec00f4c375cab6e5931f3d3c'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
