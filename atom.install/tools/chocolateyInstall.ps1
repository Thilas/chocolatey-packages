$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = '1.55.0-beta0'
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
    url            = 'https://github.com/atom/atom/releases/download/v1.55.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.55.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '59001b2091fe44ac581c509a2f04531dc53a43abd377ce4dcbc511951ab0973e'
    checksumType   = 'sha256'
    checksum64     = 'f8f45120433987de4ca6307b63703907a0cc4f890234a26159160bfc14fb0f6c'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
