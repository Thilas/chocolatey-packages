$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v0.19.3/stellarium-0.19.3.1-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v0.19.3/stellarium-0.19.3.1-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '9692ab6498ada9986d40982c39a6fb020907b1c5e1fa4026d404eb6176d07bdf'
    checksumType   = 'sha256'
    checksum64     = '26a16b86ac0c6486327e3f932da0c5d8dd0a44d06daa370cda98f362a19fa7eb'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
