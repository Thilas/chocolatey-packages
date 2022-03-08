$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = '1.61.0-beta0'
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
    url            = 'https://github.com/atom/atom/releases/download/v1.61.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.61.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '1f20fb3f05eaf3607a6f5c28429e036b50531a07e375a425c4220ec83da3638c'
    checksumType   = 'sha256'
    checksum64     = 'dcd57617d42fb7a74c756e414d49cc093bc74d7907da48bd4e5c02b79b9da727'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
