﻿$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$fileType    = 'zip'
$packageArgs = @{
    packageName = 'ilspy'
    destination = $toolsDir
}
# *** Automatically filled ***

$packageArgs.file64 = Get-Item ("$toolsDir\*.{0}" -f $fileType)

Get-ChocolateyUnzip @packageArgs
Remove-Item $packageArgs.file64 -ErrorAction SilentlyContinue

New-Item "$toolsDir\ilspy.exe.gui" -Type File -Force | Out-Null

$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) 'ILSpy.lnk'
if (!(Test-Path $shortcutPath)) {
    Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath "$toolsDir\ilspy.exe"
}
