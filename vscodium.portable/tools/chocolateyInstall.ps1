$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$oldPath = $false
$installationPath = Join-Path (Get-ToolsLocation) 'VSCodium'

$logPath = Join-Path $toolsDir 'vscodium.txt'
if (Test-Path $logPath) {
    $oldInstallationPath = Get-Content $logPath
    if ($oldInstallationPath -ne $installationPath) {
        if (Test-Path $oldInstallationPath) {
            $oldPath = $true
            $installationPath = $oldInstallationPath
            Write-Verbose "Old Installation Path detected"
        }
    }
}
Write-Verbose "Installation Path: $installationPath"

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'vscodium.portable'
    url            = 'https://github.com/VSCodium/vscodium/releases/download/1.74.2.23007/VSCodium-win32-ia32-1.74.2.23007.zip'
    url64bit       = 'https://github.com/VSCodium/vscodium/releases/download/1.74.2.23007/VSCodium-win32-x64-1.74.2.23007.zip'
    unzipLocation  = $installationPath
    checksum       = '275a08cb93cf3d502fa55eab9a6e1888b75808bac74299afd759f04d6d2a2748'
    checksumType   = 'sha256'
    checksum64     = 'fbf2d494118bec1476df5d0e2500f9c3845a2e959fdb861671c075eb25cc6ae4'
    checksumType64 = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

if (!$oldPath) {
    # Enable Portable mode (for new installation path only)
    $dataPath = Join-Path $installationPath 'data'
    New-Item -ItemType Directory -Path $dataPath -Force -ErrorAction SilentlyContinue
}

$binPath = Join-Path $installationPath 'bin\codium.cmd'
Install-BinFile -Name 'codium' -Path $binPath

Set-Content $logPath $installationPath -Encoding UTF8 -Force

$shortcutName = 'VSCodium.lnk'
$vscodiumPath = Join-Path $installationPath 'VSCodium.exe'
$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) $shortcutName
Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath $vscodiumPath
