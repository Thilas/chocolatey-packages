$packageArgs = @{
  packageName    = 'subtitleedit'
  url            = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/3.4.13/SubtitleEdit-3.4.13-Setup.zip'
  unzipLocation  = Join-Path (Join-Path $env:TEMP 'chocolatey') 'subtitleedit'
  checksum       = 'XXX'
  checksumType   = 'sha1'
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName    = 'subtitleedit'
  fileType       = 'exe'
  file           = Join-Path $tempDir 'SubtitleEdit-3.4.13-Setup.exe'
  silentArgs     = '/VERYSILENT'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs
