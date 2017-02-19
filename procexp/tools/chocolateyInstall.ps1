$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'procexp'
  url            = 'https://download.sysinternals.com/files/ProcessExplorer.zip'
  unzipLocation  = $toolsDir
  checksum       = '7c3da162469fd9e95a2a0bd914ee41b443601cd776b53b8db9d9556fbe38c2ef'
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
