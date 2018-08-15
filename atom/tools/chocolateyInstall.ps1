$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.30.0-beta2/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.30.0-beta2/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '06ede1e422435500e9dee431971a264d6fee90bb329532337bffff55f7dc02a6'
    checksumType   = 'sha256'
    checksum64     = '213e5a8d84df18ee4be7ea5917fa43f11efd135122db60dc714fc4be337157a5'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
