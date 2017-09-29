$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'stellarium'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/stellarium/files/Stellarium-win32/0.16.1/stellarium-0.16.1-win32.exe/download'
  url64bit       = 'https://sourceforge.net/projects/stellarium/files/Stellarium-win64/0.16.1/stellarium-0.16.1-win64.exe/download'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  checksum       = '896027448d81b4b64d930960be1cdaca286f28995340b79b8e6739bd6a07d242'
  checksumType   = 'sha256'
  checksum64     = '159248afa93668c1239b5102188160dbc83802e02e1b9670ba74c8a039db65b4'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
