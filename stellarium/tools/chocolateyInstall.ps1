# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'stellarium'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/stellarium/files/Stellarium-win32/0.15.1/stellarium-0.15.1-win32.exe/download'
  url64bit       = 'https://sourceforge.net/projects/stellarium/files/Stellarium-win64/0.15.1/stellarium-0.15.1-win64.exe/download'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  checksum       = '0d4d0345ef11c01706c69619ba85cb17f6a474002d9932786c721d3620390c6c'
  checksumType   = 'sha256'
  checksum64     = '01078da42e17622c605867d89b5b6067e48ae7fccb214fe6d3acfd687e77c9d1'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
