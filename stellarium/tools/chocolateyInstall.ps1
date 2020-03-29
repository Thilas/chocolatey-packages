$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v0.20.0/stellarium-0.20.0-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v0.20.0/stellarium-0.20.0-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '4ee4f96a132bd5fe2853aa8e4d430e6e27f6b1999eaae0ffe257ebcb7c5331b9'
    checksumType   = 'sha256'
    checksum64     = '3670bc90c0d2f62ef6bf722e407a26fcc8d5fec21542e89633d319942f394828'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
