$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.29.0-beta2/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.29.0-beta2/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = 'a3bd4c3229e1ff11288e417eefbb904b6be22a3c3b20a1be1e766d71963f8d0a'
    checksumType   = 'sha256'
    checksum64     = '60520f374f0e4965950a240bd61b69f6deacc4077b419a5b99dd61cfeb36fa89'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
