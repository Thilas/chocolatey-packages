$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. "$toolsDir\Get-PackageParameters.ps1"

$packageVersion = $Env:ChocolateyPackageVersion
$packageParameters = Get-PackageParameters

If ($packageParameters.ContainsKey('InstallationPath')) {
  $installationPath = Join-Path $packageParameters.Item('InstallationPath') $packageVersion
} ElseIf ($packageParameters.ContainsKey('InstallLocation')) {
  $installationPath = Join-Path $packageParameters.Item('InstallLocation') $packageVersion
} Else {
  $forceX86 = If ($Env:ChocolateyForceX86) { Get-ProcessorBits 64 } Else { $false }
  $programFilesPath = If ($forceX86) { ${Env:ProgramFiles(x86)} } Else { $Env:ProgramFiles }
  $installationPath = Join-Path $programFilesPath "Eclipse $packageVersion"
}
Write-Verbose "Installation Path: $installationPath"

$multiUser = $packageParameters.ContainsKey('Multi-User')

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'eclipse'
  url            = 'https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/oxygen/1a/eclipse-jee-oxygen-1a-win32.zip&r=1'
  url64bit       = 'https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/oxygen/1a/eclipse-jee-oxygen-1a-win32-x86_64.zip&r=1'
  unzipLocation  = $installationPath
  checksum       = 'c3c0cbb83ed351e027dd5867cc0ebbd947aff5bb78f68c4f7abb16ff77f05729'
  checksumType   = 'sha256'
  checksum64     = 'a12a6054afc830f9dd4896607b4d77448826e9356747af57002a41a5963f7416'
  checksumType64 = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

$logPath = Join-Path $Env:ChocolateyPackageFolder "eclipse.$packageVersion.txt"
Set-Content $logPath $installationPath -Encoding UTF8 -Force

$shortcutName = "Eclipse $packageVersion.lnk"
$eclipsePath = Join-Path $installationPath 'eclipse\eclipse.exe'

If ($multiUser) {
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
} Else {
  $shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) $shortcutName
  Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath $eclipsePath -PinToTaskbar
}
