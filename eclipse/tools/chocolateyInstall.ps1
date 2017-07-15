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
  url            = 'https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/oxygen/R/eclipse-jee-oxygen-R-win32.zip&r=1'
  url64bit       = 'https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/oxygen/R/eclipse-jee-oxygen-R-win32-x86_64.zip&r=1'
  unzipLocation  = $installationPath
  checksum       = 'ed99165e51fc24d18e54ea47c7fe73e9c23353c13c76b951c74b4a2bc370166c'
  checksumType   = 'sha256'
  checksum64     = '1250d72beb576e546a9426592558b9f8d13b02e8d7be93ee433b39455e52a4df'
  checksumType64 = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

$logPath = Join-Path $Env:ChocolateyPackageFolder "eclipse.$packageVersion.txt"
Set-Content $logPath $installationPath -Encoding UTF8 -Force

$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) "Eclipse $packageVersion.lnk"
$targetPath = Join-Path $installationPath 'eclipse\eclipse.exe'
Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath $targetPath -PinToTaskbar
