$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'airserver'
    softwareName   = 'AirServer *'
    fileType       = 'msi'
    url            = 'http://airserver.blob.core.windows.net/pc32/AirServer-5.5.9-x86.msi'
    url64bit       = 'http://airserver.blob.core.windows.net/pc32/AirServer-5.5.9-x64.msi'
    silentArgs     = '/qn /norestart'
    checksum       = '90ac4e529688401aa0db3d8a2002192e79d8544c5e9892a3bea9e697e9e56bda'
    checksumType   = 'sha256'
    checksum64     = '902dcdd63f32c36612fd232e9c92f5dd127015b8501ddc7438c53ec39a2fb871'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
