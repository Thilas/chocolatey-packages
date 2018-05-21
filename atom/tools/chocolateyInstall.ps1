$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.28.0-beta1/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.28.0-beta1/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '171477eec3233e91d526021fd7fc0f6ce3db8cfc1c92314c1cd77e9531b182fc'
    checksumType   = 'sha256'
    checksum64     = 'c6724dc6b1edf2ec7768367411b0b848fb2efbd784dd9944243a9a8d92b89d1f'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
