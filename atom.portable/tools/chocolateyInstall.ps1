$ErrorActionPreference = 'Stop'

$installationPath = Join-Path (Get-ToolsLocation) 'Atom'
Write-Verbose "Installation Path: $installationPath"

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom.portable'
    url            = 'https://github.com/atom/atom/releases/download/v1.56.0-beta0/atom-windows.zip'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.56.0-beta0/atom-x64-windows.zip'
    unzipLocation  = $installationPath
    checksum       = '1bb3f390d631973a97e5d6891f5bef6ca53c549094904f7dcaf208cb4c57161d'
    checksumType   = 'sha256'
    checksum64     = 'e83cea8062db63b7cd3a72d707f7ef7ac800f509550f64164497b0a7460637b3'
    checksumType64 = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

# Enable Portable mode
$dataPath = Join-Path $installationPath '.atom\electronUserData'
New-Item -ItemType Directory -Path $dataPath -Force -ErrorAction SilentlyContinue

$binPath = Join-Path $installationPath '*\atom*.exe' | Get-Item
Install-BinFile -Name 'atom' -Path $binPath.FullName

$logPath = Join-Path $Env:ChocolateyPackageFolder 'atom.txt'
Set-Content $logPath $installationPath -Encoding UTF8 -Force

$shortcutName = 'Atom.lnk'
$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) $shortcutName
Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath $binPath
