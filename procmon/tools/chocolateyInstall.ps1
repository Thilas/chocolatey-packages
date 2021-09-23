$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'procmon'
    url            = 'https://download.sysinternals.com/files/ProcessMonitor.zip'
    unzipLocation  = $toolsDir
    checksum       = '508681293120caa2afd2aeaea72445d0bf37114e6590ac906f220fc1e950b94f'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

@('procmon') | ForEach-Object {
    New-Item "$toolsDir\$_.exe.gui" -Type File -Force | Out-Null
}

$registryPath = 'HKCU:\SOFTWARE\Sysinternals\Process Monitor'
if (!(Test-Path $registryPath)) {
    New-Item $registryPath -Force | Out-Null
}
New-ItemProperty -Path $registryPath -Name 'EulaAccepted' -Value 1 -Force | Out-Null

$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) 'Process Monitor.lnk'
if (-not (Test-Path $shortcutPath)) {
    Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath "$toolsDir\procmon.exe"
}
