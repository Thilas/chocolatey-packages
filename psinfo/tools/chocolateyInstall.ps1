$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'psinfo'
    url            = 'https://download.sysinternals.com/files/PSTools.zip'
    unzipLocation  = $toolsDir
    checksum       = 'a9ca77dfe03ce15004157727bb43ba66f00ceb215362c9b3d199f000edaa8d61'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

# Clean other executables from PSTools package
Remove-Item "$toolsDir\*.exe" -Exclude "PsInfo.exe", "PsInfo64.exe"

$registryPath = 'HKCU:\SOFTWARE\Sysinternals\PsInfo'
if (!(Test-Path $registryPath)) {
    New-Item $registryPath -Force | Out-Null
}
New-ItemProperty -Path $registryPath -Name 'EulaAccepted' -Value 1 -Force | Out-Null
