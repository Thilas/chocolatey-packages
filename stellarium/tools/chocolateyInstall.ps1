$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v0.19.2/stellarium-0.19.2-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v0.19.2/stellarium-0.19.2-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = 'd44c9e8e06487d830fc618053118881fb69159c3448260a4860814181bbddc76'
    checksumType   = 'sha256'
    checksum64     = '7cb40d060f12b900e05190352d47ae03375c81016e20fc235176ef22f280fd3f'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
