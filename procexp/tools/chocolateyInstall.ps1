$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'procexp'
  url            = 'https://download.sysinternals.com/files/ProcessExplorer.zip'
  unzipLocation  = $toolsDir
  checksum       = ''
  checksumType   = ''
  validExitCodes = @()
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
