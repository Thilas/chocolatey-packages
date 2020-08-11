$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = '1.51.0-beta0'
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
    url            = 'https://github.com/atom/atom/releases/download/v1.51.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.51.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = 'dfeafc4b97238f628fec86dd38c4ef3f1d1ae5ee6df27cc0b2beb1045c93ae9c'
    checksumType   = 'sha256'
    checksum64     = '5c9b1e5b10bece171d5931b27ef63a93b823c313d6fc92748f6238fd55c5296e'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
