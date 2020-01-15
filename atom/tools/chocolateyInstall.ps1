$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = '1.44.0-beta0'
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
    url            = 'https://github.com/atom/atom/releases/download/v1.44.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.44.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '389995da989b8c4b37bb9645d343b5754129c8ab653f3542b03a47d4ba05d798'
    checksumType   = 'sha256'
    checksum64     = 'b48a52b114bb8a1cbc0a8915dd189e7a0c0fff4b121ce54b4dd9488b59d1a403'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
