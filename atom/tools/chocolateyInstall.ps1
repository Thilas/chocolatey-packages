$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.30.0-beta1/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.30.0-beta1/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '5f432ae2fd0fbb698947e9637e4aba57dcc5be25f798f071bef90fb00c6d17c1'
    checksumType   = 'sha256'
    checksum64     = '56d74c30685087b961e265f383404ca46195d233e8fbbd02713aaf5b6ee86e03'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
