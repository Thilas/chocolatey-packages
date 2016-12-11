$packageArgs = @{
  packageName    = 'subtitleedit'
  url            = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/3.5.0/SubtitleEdit-3.5-Setup.zip'
  unzipLocation  = [IO.Path]::Combine($env:TEMP, 'subtitleedit')
  checksum       = '04940062a910eec82e87ad0dc7cfeffb0361b9879617d858749116c99868b90b'
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName    = 'subtitleedit'
  fileType       = 'exe'
  file           = [IO.Path]::Combine($env:TEMP, 'subtitleedit', 'SubtitleEdit-3.5-Setup.exe')
  silentArgs     = '/VERYSILENT'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs
