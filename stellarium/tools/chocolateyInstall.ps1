# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'stellarium'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/stellarium/files/Stellarium-win32/0.15.0/stellarium-0.15.0-win32.exe/download'
  url64bit       = 'https://sourceforge.net/projects/stellarium/files/Stellarium-win64/0.15.0/stellarium-0.15.0-win64.exe/download'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  checksum       = '1b411ef369e949d21bee3dc741ccf16712e86bdd6392872fb633a23489383ba1'
  checksumType   = 'sha256'
  checksum64     = '099e32491aeecff08f326e00384f58be0780a06b547433b596265ddf953098e1'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
