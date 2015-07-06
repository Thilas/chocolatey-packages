$packageName = '{{PackageName}}'
$installerType = 'exe'
$url = '{{DownloadUrl}}'
$url64 = $url
$silentArgs = '-y'
$validExitCodes = @(0)

$installOverride = $env:chocolateyInstallOverride
if (!$installOverride) {
  $env:IMDISK_SILENT_SETUP = 1
  Write-Host "Silent mode set"
}

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"  -validExitCodes $validExitCodes
