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
  url            = 'https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/oxygen/1/eclipse-jee-oxygen-1-win32.zip&r=1'
  url64bit       = 'https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/oxygen/1/eclipse-jee-oxygen-1-win32-x86_64.zip&r=1'
  unzipLocation  = $installationPath
  checksum       = '442b407d3036f03e8f11d2ba0e45bd5ebc8f66832d1b847dd85f25a33e4c82c3'
  checksumType   = 'sha256'
  checksum64     = 'a7301b170d171ea04b34eae72302f7ec47643b82e5bfa855f28d28e8d310c20c'
  checksumType64 = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

$logPath = Join-Path $Env:ChocolateyPackageFolder "eclipse.$packageVersion.txt"
Set-Content $logPath $installationPath -Encoding UTF8 -Force

$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) "Eclipse $packageVersion.lnk"
$targetPath = Join-Path $installationPath 'eclipse\eclipse.exe'
Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath $targetPath -PinToTaskbar
