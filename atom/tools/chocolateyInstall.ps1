$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    softwareName   = 'Atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.35.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.35.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = 'b19442f60a9640613467ea019464ae4447ac1e6339bc7b5cef8768321ac86ae6'
    checksumType   = 'sha256'
    checksum64     = '2c9629966cbdacfa8d5f5afe6606e4ef261fc644ceb1c39842e135a080561929'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
