$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v24.1/stellarium-24.1-qt5-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v24.1/stellarium-24.1-qt6-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '0f7963b69f0acb8192b91ab12e15f2ccda953ed39c0c3c47e34bfd53f6ce02a8'
    checksumType   = 'sha256'
    checksum64     = 'd9db848d9d11597c2a916f0ababf5c489103714834706ab1c79f1b374c954cb2'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
