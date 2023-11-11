$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'procexp'
    url            = 'https://download.sysinternals.com/files/ProcessExplorer.zip'
    unzipLocation  = $toolsDir
    checksum       = 'c50bddaaacb26c5654f845962f9ee34db6ce26b62f94a03bb59f3b5a6eea1922'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

@('procexp', 'procexp64') | ForEach-Object {
    New-Item "$toolsDir\$_.exe.gui" -Type File -Force | Out-Null
}

$registryPath = 'HKCU:\SOFTWARE\Sysinternals\Process Explorer'
if (!(Test-Path $registryPath)) {
    New-Item $registryPath -Force | Out-Null
}
New-ItemProperty -Path $registryPath -Name 'EulaAccepted' -Value 1 -Force | Out-Null

$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) 'Process Explorer.lnk'
if (!(Test-Path $shortcutPath)) {
    $targetPath = if ([Environment]::Is64BitOperatingSystem) { 'procexp64.exe' } else { 'procexp.exe' }
    Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath "$toolsDir\$targetPath"
}
