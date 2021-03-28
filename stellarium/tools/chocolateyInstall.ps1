$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v0.21.0/stellarium-0.21.0-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v0.21.0/stellarium-0.21.0-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '31b81ef2ed698bdb63d0a9c8dcaaac136660c73ff0b1f38357cfde0bdbbe593b'
    checksumType   = 'sha256'
    checksum64     = 'f492e4967b525cd3e4652cf86b68eb0d3b954cd5aa8d4cbac3a452d4936e9d66'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
