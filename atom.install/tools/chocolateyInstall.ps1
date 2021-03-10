$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = '1.56.0-beta0'
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
    url            = 'https://github.com/atom/atom/releases/download/v1.56.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.56.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '9b3a8da2fe47441a7c5f2a2ad10cd08d96f23984f6613a728a77832d48419d46'
    checksumType   = 'sha256'
    checksum64     = '7b32e85ffd3fd77047dc2b0adb739f167fab49e7ccd8f94f87348559e9ffeb41'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
