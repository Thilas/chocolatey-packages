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
    packageName    = 'vscodium-insiders.portable'
    url64bit       = 'https://github.com/VSCodium/vscodium-insiders/releases/download/1.103.05143-insider/VSCodium-win32-x64-1.103.05143-insider.zip'
    unzipLocation  = $installationPath
    checksum64     = '1b69e690d4288031829a87fdf3353ff82cfc9b4c0864c4a11dc68b90726c7789'
    checksumType64 = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

if (!$oldPath) {
    # Enable Portable mode (for new installation path only)
    $dataPath = Join-Path $installationPath 'data'
    New-Item -ItemType Directory -Path $dataPath -Force -ErrorAction SilentlyContinue
}

$binPath = Join-Path $installationPath 'bin\codium-insiders.cmd'
Install-BinFile -Name 'codium-insiders' -Path $binPath

Set-Content $logPath $installationPath -Encoding UTF8 -Force

$shortcutName = 'VSCodium - Insiders.lnk'
$vscodiumPath = Join-Path $installationPath 'VSCodium - Insiders.exe'
$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) $shortcutName
Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath $vscodiumPath
