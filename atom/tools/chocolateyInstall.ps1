$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.32.1/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.32.1/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '859220b1c2c0d8c8da5087cea3aabc4f19fdc5061e335f32c5009ce8e93d163b'
    checksumType   = 'sha256'
    checksum64     = 'bccf5146175177bbb11c8596da37afa9aa854d3bc3ddf0adc6e71eeb0fa1f244'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
