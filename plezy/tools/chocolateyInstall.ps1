$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$fileType    = '7z'
$packageArgs = @{
    packageName = 'plezy'
    destination = $toolsDir
}
# *** Automatically filled ***

$packageArgs.file64 = Get-Item ("$toolsDir\*.{0}" -f $fileType)

Get-ChocolateyUnzip @packageArgs
Remove-Item $packageArgs.file64 -ErrorAction SilentlyContinue

New-Item "$toolsDir\plezy.exe.gui" -Type File -Force | Out-Null

$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) 'Plezy.lnk'
if (!(Test-Path $shortcutPath)) {
    Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath "$toolsDir\plezy.exe"
}
