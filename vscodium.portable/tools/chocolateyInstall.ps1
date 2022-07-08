$ErrorActionPreference = 'Stop'

$oldPath = $false
$installationPath = Join-Path (Get-ToolsLocation) 'VSCodium'

$logPath = Join-Path $Env:ChocolateyPackageFolder 'vscodium.txt'
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
    url            = 'https://github.com/VSCodium/vscodium/releases/download/1.69.0/VSCodium-win32-ia32-1.69.0.zip'
    url64bit       = 'https://github.com/VSCodium/vscodium/releases/download/1.69.0/VSCodium-win32-x64-1.69.0.zip'
    unzipLocation  = $installationPath
    checksum       = '303c7ec9e3c208274784c8c6169b02ed3a25c585e97bf777e63c008e85af84eb'
    checksumType   = 'sha256'
    checksum64     = '0791409b8fb581143a78fccf8f36ebd1e10469a756e10da9a10432eeb3c4430b'
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
