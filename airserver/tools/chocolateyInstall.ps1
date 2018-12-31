$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'airserver'
    softwareName   = ''
    fileType       = 'msi'
    url            = 'http://dl.airserver.com/pc32/AirServer-5.5.4-x86.msi'
    url64bit       = 'http://dl.airserver.com/pc32/AirServer-5.5.4-x64.msi'
    silentArgs     = '/qn /norestart'
    checksum       = 'de0799d889afa16c476f58036917b5115147ac1455f80c907d7bc0b178f367e7'
    checksumType   = 'sha256'
    checksum64     = 'caf2cbacf465c631a01d5507607e9f483296c6f58e90577ce4ae7cc8eaf5f8e8'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
