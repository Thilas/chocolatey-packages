$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'procmon'
    url            = 'https://download.sysinternals.com/files/ProcessMonitor.zip'
    unzipLocation  = $toolsDir
    checksum       = '82d0ef52952760bd0f512137c744c6b53d7ec6b98c4019a8215f194a2bf74094'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

@('Procmon', 'Procmon64') | ForEach-Object {
    New-Item "$toolsDir\$_.exe.gui" -Type File -Force | Out-Null
}

$registryPath = 'HKCU:\SOFTWARE\Sysinternals\Process Monitor'
if (!(Test-Path $registryPath)) {
    New-Item $registryPath -Force | Out-Null
}
New-ItemProperty -Path $registryPath -Name 'EulaAccepted' -Value 1 -Force | Out-Null

$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) 'Process Monitor.lnk'
if (!(Test-Path $shortcutPath)) {
    $targetPath = if ([Environment]::Is64BitOperatingSystem) { 'Procmon64.exe' } else { 'Procmon.exe' }
    Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath "$toolsDir\$targetPath"
}
