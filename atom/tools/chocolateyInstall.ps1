$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.26.0-beta2/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.26.0-beta2/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '72f707b0eae6c0a37f2bf6157770301d36101781151d7386e3622e69a9fc333c'
    checksumType   = 'sha256'
    checksum64     = 'b18c1698bddd1ac4d64ded58aab78f536191eb84d43bf73655cf6b4180c4a1b1'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
