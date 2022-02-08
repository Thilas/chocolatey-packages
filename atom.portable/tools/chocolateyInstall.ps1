$ErrorActionPreference = 'Stop'

$installationPath = Join-Path (Get-ToolsLocation) 'Atom'
Write-Verbose "Installation Path: $installationPath"

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom.portable'
    url            = 'https://github.com/atom/atom/releases/download/v1.60.0-beta0/atom-windows.zip'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.60.0-beta0/atom-x64-windows.zip'
    unzipLocation  = $installationPath
    checksum       = '128db65908aa6f3b8b2b781e5f03e64a9fdc918b17ba71949b4b64d6ec418cd5'
    checksumType   = 'sha256'
    checksum64     = 'c8fdc707c1a5dadeb447cc72588c7e7996b62b46b27754f0c73ce284f4adb378'
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
