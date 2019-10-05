$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = ''
# *** Automatically filled ***

if ($version -eq (Get-UninstallRegistryKey $softwareName).DisplayVersion) {
    Write-Host "Version $version is already installed."
}
return

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    softwareName   = $softwareName
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.41.0-beta1/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.41.0-beta1/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '146b96e07f0598fcc21d75a7681b333605f728f07064f1fd86b1b9d46c314da6'
    checksumType   = 'sha256'
    checksum64     = '6bc4bf7f471e72d6c303b724a0523b1aa42c5e8e3d122f5cf496ffa4ea77aac6'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
