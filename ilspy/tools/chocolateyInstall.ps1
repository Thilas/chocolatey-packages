$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
    packageName   = 'ilspy'
    url           = 'https://github.com/icsharpcode/ILSpy/releases/download/v3.2.0/ILSpy_binaries_3.2.0.3856.zip'
    unzipLocation = $toolsDir
    checksum      = 'd1bf46034e334d456b0f7698b6493e21e664e3f3c12b1206fcf6feab8a8c6b5f'
    checksumType  = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

New-Item "$toolsDir\ilspy.exe.gui" -Type File -Force | Out-Null

$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) 'ILSpy.lnk'
if (-not (Test-Path $shortcutPath)) {
    Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath "$toolsDir\ilspy.exe"
}
