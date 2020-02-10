$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = '1.44.0'
# *** Automatically filled ***

if ($version -eq (Get-UninstallRegistryKey $softwareName).DisplayVersion) {
    Write-Host "Version $version is already installed."
    return
}

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    softwareName   = $softwareName
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.44.0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.44.0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '0578cf0322dd1203fd18fb3935d6de8159b3a2f0bb1b5a15589b80e61c52410f'
    checksumType   = 'sha256'
    checksum64     = '39a2a41163a13e4e95563d62e5f74f5eb7576a77eba3aa7a86529907ed60ab63'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
