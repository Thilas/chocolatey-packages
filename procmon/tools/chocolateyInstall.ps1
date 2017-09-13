$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'procmon'
  url            = 'https://download.sysinternals.com/files/ProcessMonitor.zip'
  unzipLocation  = $toolsDir
  checksum       = '7ea0c87179d1daa3e46904e07469633426a81ef1063f338dca31c7dc641e0ba4'
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
