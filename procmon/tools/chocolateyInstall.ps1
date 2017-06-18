$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'procmon'
  url            = 'https://download.sysinternals.com/files/ProcessMonitor.zip'
  unzipLocation  = $toolsDir
  checksum       = 'fa957e373a05d506e63cf3d566d56116dfc6d00efd10e043b159660a55c90599'
  checksumType   = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

@('procmon') | % {
  New-Item (Join-Path $toolsDir "$_.exe.gui") -Type file -Force | Out-Null
}

New-Item 'HKCU:\SOFTWARE\Sysinternals\Process Monitor' -Force | New-ItemProperty -Name 'EulaAccepted' -Value 1 -Force | Out-Null

$shortcutPath = Join-Path $([Environment]::GetFolderPath('CommonPrograms')) 'Process Monitor.lnk'
If (-not (Test-Path $shortcutPath)) {
  $targetPath = Join-Path $toolsDir 'procmon.exe'
  Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath $targetPath
}
