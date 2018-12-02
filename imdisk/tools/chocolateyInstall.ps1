$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'imdisk'
    fileType       = 'exe'
    url            = 'http://www.ltr-data.se/files/imdiskinst_2.0.10.exe'
    silentArgs     = '-y'
    checksum       = '1e5291ad53e8b90f88882eeef791e8b5f162aef020e55a633cec4d1581acce4e'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

$installOverride = $env:chocolateyInstallOverride
if (!$installOverride) {
    $env:IMDISK_SILENT_SETUP = 1
    Write-Host "Silent mode set"
}

Install-ChocolateyPackage @packageArgs
