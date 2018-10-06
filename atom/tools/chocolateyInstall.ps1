$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.32.0-beta3/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.32.0-beta3/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = 'afbbfe13527c1e0b17c54c17a8dea06936d09c609b3ab196ede366957eace300'
    checksumType   = 'sha256'
    checksum64     = '19eb0ea9b8db12849dc6c9b0ef8f77d57f2ce953388a95e855b14a454ccbbfde'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
