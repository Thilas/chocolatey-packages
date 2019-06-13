$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    softwareName   = 'Atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.39.0-beta1/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.39.0-beta1/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '25bcf1c4fcf5bf67f0b1041c5b2cf1891e4c2e4c4a9188785918b73c48509a07'
    checksumType   = 'sha256'
    checksum64     = '1b6b669bddee887b71ff9aabdf7398ec533289e008dbac57f3fd01416e61be37'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
