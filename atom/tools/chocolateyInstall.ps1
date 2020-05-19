$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = '1.48.0-beta0'
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
    url            = 'https://github.com/atom/atom/releases/download/v1.48.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.48.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = 'b83e9a1d9b9af42dbec0c8cac7326a957577b94b3899c8afef9adf28cbc15489'
    checksumType   = 'sha256'
    checksum64     = '7afd2e14982060a7752bc650c3a6e1477bf6d8130c0c47b7cd8157359c006a05'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
