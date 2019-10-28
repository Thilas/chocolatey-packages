$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = '1.42.0.20191029-beta0'
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
    url            = 'https://github.com/atom/atom/releases/download/v1.42.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.42.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '03ae46e5fec51ec253df30dd9f8af10a6272f2c87da59c9f65dcdf684af9d1b2'
    checksumType   = 'sha256'
    checksum64     = '5dd3b628bb28afc5d15c6e49050157ec1983351377e2855ba4398625234649c6'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
