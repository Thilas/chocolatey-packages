$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    softwareName   = 'Atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.36.0-beta2/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.36.0-beta2/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = 'fca6c78b28bbc33dc10c2b2f85b95a9f6b17933531d344939e307f977681c53d'
    checksumType   = 'sha256'
    checksum64     = '28100081544a74a852cc8192e15d60ef0632c3b8d3bcfcb9d97bb1f26df22a00'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
