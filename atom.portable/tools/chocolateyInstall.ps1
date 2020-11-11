$ErrorActionPreference = 'Stop'

$installationPath = Join-Path (Get-ToolsLocation) 'Atom'
Write-Verbose "Installation Path: $installationPath"

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom.portable'
    url            = 'https://github.com/atom/atom/releases/download/v1.54.0-beta0/atom-windows.zip'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.54.0-beta0/atom-x64-windows.zip'
    unzipLocation  = $installationPath
    checksum       = 'a8aa7df9c0dd594779ef9466a21e39f58a8e75ee6406d25ced531f410eeb2060'
    checksumType   = 'sha256'
    checksum64     = '38fa94a4ff59d91306a9498dbed1e5e0813b31d58fbfe1eab85245267ea94cd6'
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
