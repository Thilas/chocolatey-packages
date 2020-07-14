$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = '1.50.0-beta0'
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
    url            = 'https://github.com/atom/atom/releases/download/v1.50.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.50.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = 'f75e41e612ebd8d9cc033a6077a1b125a107e86e61fd7443560ff38a89eca838'
    checksumType   = 'sha256'
    checksum64     = '261eb7427861274322defa20f88f019138b96fa122d831c599618c9f071c0fdb'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
