$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'procmon'
  url            = 'https://download.sysinternals.com/files/ProcessMonitor.zip'
  unzipLocation  = $toolsDir
  checksum       = '8ce4faf183319164520fe5efd25fc302d8aef9ffffdf5945af9c945b49a98c69'
  checksumType   = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

@('procmon') | % {
  New-Item (Join-Path $toolsDir "$_.exe.gui") -Type file -Force | Out-Null
}

New-Item 'HKCU:\SOFTWARE\Sysinternals\Process Monitor' -Force | New-ItemProperty -Name 'EulaAccepted' -Value 1 -Force | Out-Null

$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) 'Process Monitor.lnk'
If (-not (Test-Path $shortcutPath)) {
  $targetPath = Join-Path $toolsDir 'procmon.exe'
  Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath $targetPath
}
