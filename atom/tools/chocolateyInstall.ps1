$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    softwareName   = 'Atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.39.0-beta2/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.39.0-beta2/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = 'f4bb0edf5f52f56faae5555d71cc0751528354462f498b5a897c734560ff8ea8'
    checksumType   = 'sha256'
    checksum64     = '086f8bf961aa934f94e92dea1e8a471fb245eb9f48231ee0848019c05641cecd'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
