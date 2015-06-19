$overrideArguments = $env:chocolateyInstallOverride
if (!$overrideArguments)
{
    $env:IMDISK_SILENT_SETUP = 1
    Write-Host "Silent mode set"
}
$url = 'http://www.ltr-data.se/files/imdiskinst.exe'
Install-ChocolateyPackage 'imdisk' 'exe' '-y' "$url" "$url"