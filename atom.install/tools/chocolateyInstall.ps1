$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = '1.58.0-beta0'
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
    url            = 'https://github.com/atom/atom/releases/download/v1.58.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.58.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '10f6a396734660f41b25a754798cedc1d3453835fb2803ff386f955b29f6f500'
    checksumType   = 'sha256'
    checksum64     = 'f8a95ee9a0587574530ba49e80a665a21e082057de6d5731e9a8e58006468070'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
