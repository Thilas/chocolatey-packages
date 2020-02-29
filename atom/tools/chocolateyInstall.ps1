$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = '1.45.0-beta0'
# *** Automatically filled ***

if (!$Env:ChocolateyForce -and $version -eq (Get-UninstallRegistryKey $softwareName).DisplayVersion) {
    Write-Host "Version $version is already installed."
    return
}

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    softwareName   = $softwareName
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.45.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.45.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '034eb95566663b336c42f8023d5675b8fa6600f344b3d12e6abe7b66a0d6a2c7'
    checksumType   = 'sha256'
    checksum64     = 'fedfbd2ab96160863ed37d31160d97ed676109705ed06274ea48218c9e898467'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
