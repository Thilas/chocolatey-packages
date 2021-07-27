$ErrorActionPreference = 'Stop'

$installationPath = Join-Path (Get-ToolsLocation) 'Atom'
Write-Verbose "Installation Path: $installationPath"

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom.portable'
    url            = 'https://github.com/atom/atom/releases/download/v1.59.0-beta0/atom-windows.zip'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.59.0-beta0/atom-x64-windows.zip'
    unzipLocation  = $installationPath
    checksum       = '7cd46032a94cd3865470429cf19d8353581d38451f91af31ee906fa2b5a92cba'
    checksumType   = 'sha256'
    checksum64     = '805ce1fd2834d165d437b2d45a2ba1f1cf29e71d45438a8dcd108d39b73210f3'
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
