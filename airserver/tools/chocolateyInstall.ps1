$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'airserver'
    softwareName   = 'AirServer *'
    fileType       = 'msi'
    url            = 'https://dl.airserver.com/pc32/AirServer-5.7.1-x86.msi'
    url64bit       = 'https://dl.airserver.com/pc32/AirServer-5.7.1-x64.msi'
    silentArgs     = '/qn /norestart'
    checksum       = '7a8994db58754c4c58dc3b40fc30418a40da3fe54cf74219f787013eefb0d59d'
    checksumType   = 'sha256'
    checksum64     = '335155a6ea74324ebed809d9b7f3a07a24ea180b10d6128003fb8379d4c4d551'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
