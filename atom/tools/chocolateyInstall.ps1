$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.30.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.30.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '9e2f06277106161d800245d4c1ea4dbe11f3fc4dd363d2662cde0a2adac77c76'
    checksumType   = 'sha256'
    checksum64     = 'c9f9f25ed928ecf0b02f83677fc9d395c77128c9b4b405fe2b70d57efa3ec8f4'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
