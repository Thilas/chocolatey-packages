$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'psinfo'
    url            = ''
    unzipLocation  = $toolsDir
    checksum       = ''
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
