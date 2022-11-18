$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = '1.63.0'
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
    url            = 'https://github.com/atom/atom/releases/download/v1.63.0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.63.0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '42f9fe90e1194ee10f3f2d3f97dd62a1336750cabc156d20772ad78567c74c61'
    checksumType   = 'sha256'
    checksum64     = '92eb07c52e0f5c0f0fdfe094b6cc48096ab0a548206a00fd72aa65e473b06af3'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
