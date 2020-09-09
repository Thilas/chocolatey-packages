$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = '1.52.0-beta0'
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
    url            = 'https://github.com/atom/atom/releases/download/v1.52.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.52.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '93f9b2c70d858b55e098ae39e89c477ad5033ecfbab878fb2785ebb10d53ef34'
    checksumType   = 'sha256'
    checksum64     = '5a83c80685f0d73e7c072c09c671158f46ab2bf10981d599cea79a79477c4f65'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
