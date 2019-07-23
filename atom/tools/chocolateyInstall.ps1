$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    softwareName   = 'Atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.40.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.40.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '06796a051bf3632a16e304fff84d0344fd2aec9aa3685e7837d0159624c0f0f4'
    checksumType   = 'sha256'
    checksum64     = 'b953a5fe401fd065c865348ec8c117803c6c804080f8bb58262070e2baaa8464'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
