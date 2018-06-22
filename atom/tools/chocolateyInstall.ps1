$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.29.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.29.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = 'd2385d06ebd41a79c0f4fac3b9a1393e3f69c96aba087a48ebd0e340b6b301ac'
    checksumType   = 'sha256'
    checksum64     = '81fa06895375fe3954c3cb3a079b5d1018fa55b957d4b5c533823947cbcf873c'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
