$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.27.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.27.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '9cac28457bef0c81e6a6f8ba6e7371e8201b3e622ca6c067f069deba34fac7aa'
    checksumType   = 'sha256'
    checksum64     = '91886e2a5d542e7f4f045bcb7f4ed299075ca5ae5dbddf2210e36badd7af2127'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
