$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
    packageName   = 'ilspy'
    url           = 'https://github.com/icsharpcode/ILSpy/releases/download/v3.2-beta/ILSpy_binaries_3.2.0.3809-beta.zip'
    unzipLocation = $toolsDir
    checksum      = 'c58697b06f047d92bcdaebd155737bd151affd2bf629c833529b5f0be8e3e068'
    checksumType  = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

New-Item "$toolsDir\ilspy.exe.gui" -Type File -Force | Out-Null

$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) 'ILSpy.lnk'
if (-not (Test-Path $shortcutPath)) {
    Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath "$toolsDir\ilspy.exe"
}
