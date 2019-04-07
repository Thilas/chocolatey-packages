$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'stellarium'
    softwareName   = 'Stellarium *'
    fileType       = 'exe'
    url            = 'https://github.com/Stellarium/stellarium/releases/download/v0.19.0/stellarium-0.19.0.1-win32.exe'
    url64bit       = 'https://github.com/Stellarium/stellarium/releases/download/v0.19.0/stellarium-0.19.0.1-win64.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '0a3a1d434c433f94a0b5102fcba760b1861dfb5a1cf944fe67942739f9bbed6a'
    checksumType   = 'sha256'
    checksum64     = '88fd7a8d372d614e402860628a842d61c6424432bfd488bf848a439416eab422'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
