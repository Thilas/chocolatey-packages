$packageName = '{{PackageName}}' # arbitrary name for the package, used in messages
$installerType = 'exe' #only one of these: exe, msi, msu
$url = '{{DownloadUrl}}' # download url
$url64 = $url # '{{DownloadUrlx64}}' # 64bit URL here or remove - if installer decides, then use $url
$silentArgs = '/S' # "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT" # try any of these to get the silent installer #msi is always /quiet
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"  -validExitCodes $validExitCodes
