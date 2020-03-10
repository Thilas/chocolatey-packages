$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = '1.46.0-beta0'
# *** Automatically filled ***

if (!$Env:ChocolateyForce -and $version -eq (Get-UninstallRegistryKey $softwareName).DisplayVersion) {
    Write-Host "Version $version is already installed."
    return
}

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    softwareName   = $softwareName
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.46.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.46.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = 'd514d37cd1395eeab6e801ecf098fadb49be79e91905673b1ed37ad4806a0f11'
    checksumType   = 'sha256'
    checksum64     = '681cd6a0a0217c9d8d2ccaaa3f25a0d2306def04c3799ca3a5488b9bdab20237'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
