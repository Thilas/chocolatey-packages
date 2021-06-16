$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. "$toolsDir\Get-PackageParameters.ps1"

$packageVersion = $Env:ChocolateyPackageVersion
$packageParameters = Get-PackageParameters

if ($packageParameters.ContainsKey('InstallationPath')) {
    $installationPath = Join-Path $packageParameters.Item('InstallationPath') $packageVersion
} elseif ($packageParameters.ContainsKey('InstallLocation')) {
    $installationPath = Join-Path $packageParameters.Item('InstallLocation') $packageVersion
} else {
    $forceX86 = if ($Env:ChocolateyForceX86) { Get-ProcessorBits 64 } else { $false }
    $programFilesPath = if ($forceX86) { ${Env:ProgramFiles(x86)} } else { $Env:ProgramFiles }
    $installationPath = Join-Path $programFilesPath "Eclipse $packageVersion"
}
Write-Verbose "Installation Path: $installationPath"

$multiUser = $packageParameters.ContainsKey('Multi-User')

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'eclipse'
    url            = ''
    url64bit       = 'https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/2021-06/R/eclipse-jee-2021-06-R-win32-x86_64.zip&r=1'
    unzipLocation  = $installationPath
    checksum       = ''
    checksumType   = ''
    checksum64     = 'b0c490cc5331c21cafaa4d921df941fcc3a44f0a364d2231c9a7924797cb7a75'
    checksumType64 = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

$logPath = Join-Path $Env:ChocolateyPackageFolder "eclipse.$packageVersion.txt"
Set-Content $logPath $installationPath -Encoding UTF8 -Force

$shortcutName = "Eclipse $packageVersion.lnk"
$eclipsePath = Join-Path $installationPath 'eclipse\eclipse.exe'

if ($multiUser) {
    $shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonDesktopDirectory)) $shortcutName
    $targetPath = Join-Path $installationPath 'eclipse.bat'
    $targetContent = @"
@echo off

set ECLIPSEDIR="%LOCALAPPDATA%\Eclipse.$packageVersion"

if not exist %ECLIPSEDIR% (
  mkdir %ECLIPSEDIR%
)

start "Eclipse" "$eclipsePath" -configuration %ECLIPSEDIR%

"@
    Set-Content $targetPath $targetContent -Encoding Ascii -Force
    Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath $targetPath -IconLocation $eclipsePath
} else {
    $shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) $shortcutName
    Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath $eclipsePath -PinToTaskbar
}
