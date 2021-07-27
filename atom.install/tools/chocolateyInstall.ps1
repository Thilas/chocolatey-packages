$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = '1.59.0-beta0'
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
    url            = 'https://github.com/atom/atom/releases/download/v1.59.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.59.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '3acbc6bb5a461badc1b884622d42872b068619ecec437a960a3c09f3d0c60eb8'
    checksumType   = 'sha256'
    checksum64     = '39748604d9d53cfcb073b83b501670f3f47def95d7c7fd15243ed98fa316d247'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
