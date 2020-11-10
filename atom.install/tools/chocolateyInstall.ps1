$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = '1.54.0-beta0'
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
    url            = 'https://github.com/atom/atom/releases/download/v1.54.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.54.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '05de9e6bf83d9e56abf20debd42bbbdd6ce6b5c7abe50c87cf56123450c7f6b8'
    checksumType   = 'sha256'
    checksum64     = '6b7b75e2f07fa2534cc848509294b4064de4a0d6f82bc0372df4a6f604775b34'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
