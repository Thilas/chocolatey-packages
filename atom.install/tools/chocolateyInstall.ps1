$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = '1.63.1'
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
    url            = 'https://github.com/atom/atom/releases/download/v1.63.1/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.63.1/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = 'e612c7f2b2b079e64907ba6ace80af3cf9452cae7263719417571dbd9755d065'
    checksumType   = 'sha256'
    checksum64     = 'ad4e34c2698f5533e8bbdc4541c1bd39d5f57d99e810c1ace08329ebb85251d4'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
