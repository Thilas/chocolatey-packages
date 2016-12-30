# *** Automatically filled ***
$softwareName   = ''
$packageName    = ''
$fileType       = ''
$silentArgs     = ''
$validExitCodes = @()
# *** Automatically filled ***

$file = (Get-UninstallRegistryKey -SoftwareName $softwareName).UninstallString
if (![string]::IsNullOrEmpty($file)) { $file = $file.Replace('"', '') }

if (![string]::IsNullOrEmpty($file) -and (Test-Path $file)) {
  Uninstall-ChocolateyPackage -PackageName $packageName -FileType $fileType -SilentArgs $silentArgs -ValidExitCodes $validExitCodes -File $file
} else {
  Write-Host "$packageName has already been uninstalled by other means."
}
