$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    softwareName   = 'Atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.37.0-beta1/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.37.0-beta1/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '01b124581c116546c9d23008629baf059dd25dd9e2729c3b9713770a3926b94b'
    checksumType   = 'sha256'
    checksum64     = '2b7197ac4b511de8f8d5d4e881ae30cbbd08b771587fe84da5832e828aa2268f'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
