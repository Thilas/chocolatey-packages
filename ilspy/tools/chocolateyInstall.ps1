$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
    packageName   = 'ilspy'
    url           = 'https://github.com/icsharpcode/ILSpy/releases/download/v4.0-alpha1/ILSpy_binaries_4.0.0.4226-alpha1.zip'
    unzipLocation = $toolsDir
    checksum      = '2d37813b248fd0fd4b692cc69cd94a3aaeb193c24c3a656f21463fe4d361e8f7'
    checksumType  = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

New-Item "$toolsDir\ilspy.exe.gui" -Type File -Force | Out-Null

$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) 'ILSpy.lnk'
if (-not (Test-Path $shortcutPath)) {
    Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath "$toolsDir\ilspy.exe"
}
