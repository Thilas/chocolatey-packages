$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'procexp'
    url            = 'https://download.sysinternals.com/files/ProcessExplorer.zip'
    unzipLocation  = $toolsDir
    checksum       = '8e7d9ca5085b1a817f16889b3c123cae9bc4e76b70c4bb02c8c823f35c0db428'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

@('procexp', 'procexp64') | % {
    New-Item "$toolsDir\$_.exe.gui" -Type File -Force | Out-Null
}

$registryPath = 'HKCU:\SOFTWARE\Sysinternals\Process Explorer'
if (!(Test-Path $registryPath)) {
    New-Item $registryPath
}
New-ItemProperty -Path $registryPath -Name 'EulaAccepted' -Value 1 -Force | Out-Null

$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) 'Process Explorer.lnk'
if (-not (Test-Path $shortcutPath)) {
    $targetPath = if ([Environment]::Is64BitOperatingSystem) { 'procexp64.exe' } else { 'procexp.exe' }
    Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath "$toolsDir\$targetPath"
}
