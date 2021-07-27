$ErrorActionPreference = 'Stop'

$installationPath = Join-Path (Get-ToolsLocation) 'Atom'
Write-Verbose "Installation Path: $installationPath"

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom.portable'
    url            = 'https://github.com/atom/atom/releases/download/v1.58.0/atom-windows.zip'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.58.0/atom-x64-windows.zip'
    unzipLocation  = $installationPath
    checksum       = '842c37500cb1f0987b97340a8d8b0d1fdaaa6e1d5d610878a2e465222d1a08dc'
    checksumType   = 'sha256'
    checksum64     = '5f367cee0eda74e6a47278d0e2b6e0fafd359c5fda9f5d9e5fce194d91e0ea94'
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
