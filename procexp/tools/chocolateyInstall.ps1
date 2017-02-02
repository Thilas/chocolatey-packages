$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'procexp'
  url            = 'https://download.sysinternals.com/files/ProcessExplorer.zip'
  unzipLocation  = $toolsDir
  checksum       = '3561ac76875fc017f8873a288da59691ee67a2f405249f7099ef9c785f114fe8'
  checksumType   = 'sha256'
  validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

@('procexp', 'procexp64') | % {
  New-Item "$toolsDir\$_.exe.gui" -Type file -Force | Out-Null
}

New-Item "HKCU:\SOFTWARE\Sysinternals" -Force | Out-Null
@('Process Explorer') | % {
  New-Item (Join-Path -Path 'HKCU:\SOFTWARE\Sysinternals' -ChildPath "$_") -Force | New-ItemProperty -Name "EulaAccepted" -Value 1 -Force | Out-Null
}
