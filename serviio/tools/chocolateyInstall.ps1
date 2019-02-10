$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'serviio'
    softwareName   = 'Serviio'
    fileType       = 'exe'
    url            = 'http://download.serviio.org/releases/serviio-1.10.1-win-setup.exe'
    silentArgs     = '/S'
    checksum       = 'd5c9c5c2e8bb32d58d07d31b4f9db2f861757ba57a693644923e1f4769bb818a'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
