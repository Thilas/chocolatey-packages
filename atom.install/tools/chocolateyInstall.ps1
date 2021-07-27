$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = '1.58.0'
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
    url            = 'https://github.com/atom/atom/releases/download/v1.58.0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.58.0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = 'b8bbf1da5fd7abe035d29cadd13dff63dc2ee31e5e8de477de5fb8a3b1c810ea'
    checksumType   = 'sha256'
    checksum64     = 'a21c8cf1c401272fada44f48233cf9ba665f66e2a02734d59d566a71b3443272'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
