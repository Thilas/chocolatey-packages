﻿$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$fileType    = 'zip'
$packageArgs = @{
    packageName = 'ilspy'
    destination = $toolsDir
}
# *** Automatically filled ***

$packageArgs.file = Get-Item ("$toolsDir\*.{0}" -f $fileType)

Get-ChocolateyUnzip @packageArgs
Remove-Item $packageArgs.file -ErrorAction SilentlyContinue

New-Item "$toolsDir\ilspy.exe.gui" -Type File -Force | Out-Null

$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) 'ILSpy.lnk'
if (-not (Test-Path $shortcutPath)) {
    Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath "$toolsDir\ilspy.exe"
}
