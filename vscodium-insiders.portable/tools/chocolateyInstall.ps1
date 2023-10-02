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
    url            = 'https://github.com/VSCodium/vscodium/releases/download/1.82.2.23257/VSCodium-win32-ia32-1.82.2.23257.zip'
    url64bit       = 'https://github.com/VSCodium/vscodium/releases/download/1.82.2.23257/VSCodium-win32-x64-1.82.2.23257.zip'
    unzipLocation  = $installationPath
    checksum       = 'b4da09a7b9265ae38632c2a2e69bcbfe80330c038805be6b516f580defd06775'
    checksumType   = 'sha256'
    checksum64     = '2c4188ff559be4d31524f5a7eb6cec5d069e20ea96cb3524e6de022bc5fe6bde'
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

$shortcutName = 'VSCodium - Insiders.lnk'
$vscodiumPath = Join-Path $installationPath 'VSCodium - Insiders.exe'
$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) $shortcutName
Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath $vscodiumPath
