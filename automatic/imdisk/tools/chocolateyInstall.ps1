#Items that could be replaced based on what you call chocopkgup.exe with
#{{PackageName}} - Package Name (should be same as nuspec file and folder) |/p
#{{PackageVersion}} - The updated version | /v
#{{DownloadUrl}} - The url for the native file | /u
#{{PackageFilePath}} - Downloaded file if including it in package | /pp
#{{PackageGuid}} - This will be used later | /pg
#{{DownloadUrlx64}} - The 64bit url for the native file | /u64

$packageName = '{{PackageName}}' # arbitrary name for the package, used in messages
$installerType = 'exe' #only one of these: exe, msi, msu
$url = '{{DownloadUrl}}' # download url
#$url64 = '{{DownloadUrlx64}}' # 64bit URL here or remove - if installer decides, then use $url
$silentArgs = '-y' # "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT" # try any of these to get the silent installer #msi is always /quiet
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

$installOverride = $env:chocolateyInstallOverride
if (!$installOverride) {
  $env:IMDISK_SILENT_SETUP = 1
  Write-Host "Silent mode set"
}

#Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"  -validExitCodes $validExitCodes
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url"  -validExitCodes $validExitCodes
