$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.33.0-beta2/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.33.0-beta2/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '9300af3d7bedf7f015a4425b2d436a9e93ee518bf678318a2d6cb7e63b96fc52'
    checksumType   = 'sha256'
    checksum64     = '484d6d1dd749be1d91a2533c16f8c31df7cd35ae7cbf41c168dbfc4d805bb647'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
