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

# *** Automatically filled ***
$packageArgs = @{
  packageName    = 'eclipse'
  url            = 'http://eclipse.mirror.triple-it.nl/technology/epp/downloads/release/mars/1/eclipse-jee-mars-1-win32.zip'
  url64bit       = 'http://eclipse.mirror.triple-it.nl/technology/epp/downloads/release/mars/1/eclipse-jee-mars-1-win32-x86_64.zip'
  unzipLocation  = $installationPath
  checksum       = 'fd0e5ceebc2a5b40274cb6146e78a4c3'
  checksumType   = 'md5'
  checksum64     = '2917778fd8604cd2ba58453c6cb7a6bc'
  checksumType64 = 'md5'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

$logPath = Join-Path $Env:ChocolateyPackageFolder "eclipse.$packageVersion.txt"
Set-Content $logPath $installationPath -Encoding UTF8 -Force

$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) "Eclipse $packageVersion.lnk"
$targetPath = Join-Path $installationPath 'eclipse\eclipse.exe'
Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath $targetPath -PinToTaskbar
