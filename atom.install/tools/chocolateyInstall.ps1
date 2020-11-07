$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = '1.52.0.20201107'
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
    url            = 'https://github.com/atom/atom/releases/download/v1.52.0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.52.0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = 'df947bddc9499285bdc6f784b8f27f72d59b967fa5357d5a6d86ab5a8f8629db'
    checksumType   = 'sha256'
    checksum64     = 'bc54deccf0822ab1f2212c8c0780c0adc1110d8373ddcf8bdb070eed3afcb078'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
