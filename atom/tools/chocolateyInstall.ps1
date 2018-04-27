$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.27.0-beta1/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.27.0-beta1/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '828c149466b9b753d18d78d920278ae3c0c1824648c1b99f6cff98d5dbfc871e'
    checksumType   = 'sha256'
    checksum64     = '1361917be9b99219ce31b35e22f188f7a4b0418f9a2dbce8fae3b31e0250290f'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
