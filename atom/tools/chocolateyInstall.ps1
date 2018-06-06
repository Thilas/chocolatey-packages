$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.28.0-beta3/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.28.0-beta3/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '3b6a3080bf4e3f4f3cacd9798c1822cc49ec0111db3fb3077d155a6ca678176e'
    checksumType   = 'sha256'
    checksum64     = '2b5f54ae71e84f0daad43ab30818bb0e3097ff39af6a3376104d8ec29a1a8282'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
