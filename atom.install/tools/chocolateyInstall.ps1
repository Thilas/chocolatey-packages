$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = '1.60.0-beta0'
# *** Automatically filled ***

if (!$Env:ChocolateyForce -and $version -eq (Get-UninstallRegistryKey $softwareName).DisplayVersion) {
    Write-Host "Version $version is already installed."
    return
}

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom.install'
    softwareName   = $softwareName
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.60.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.60.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '12c5395cbde90fc91a5944e4bad213a3a7c5270be03247e3e6487b34d7e12e28'
    checksumType   = 'sha256'
    checksum64     = '13fa69d703c313dbab3977695f1fa11f7d3bdb308528270b35d98a711623bc41'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
