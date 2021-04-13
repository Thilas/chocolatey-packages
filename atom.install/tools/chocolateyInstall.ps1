$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = '1.57.0-beta0'
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
    url            = 'https://github.com/atom/atom/releases/download/v1.57.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.57.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '9f5558855a2f7d96e08a9afd13ee27063f5427b7856e2c5c61c58144fc41ef37'
    checksumType   = 'sha256'
    checksum64     = '8439c51363c570dcdd5c8537a37b434aff66d11bf300207bea3f47ee34a9fe3a'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
