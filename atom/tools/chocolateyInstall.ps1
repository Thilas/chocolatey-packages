$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.32.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.32.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '3bc65271c4462bfe93400f37edde4284b5c8a9c047e5147d379afe17b19c51b7'
    checksumType   = 'sha256'
    checksum64     = '3d544a81aee287027ddbdef0fe3cf930fc84424d4b660b95588cd8ad834b6731'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
