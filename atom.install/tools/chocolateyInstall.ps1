$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = '1.53.0-beta0'
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
    url            = 'https://github.com/atom/atom/releases/download/v1.53.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.53.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = 'e596c20b2f4dddb83b17584903e4738fb2c1e7133e5a24a86c2313d270104775'
    checksumType   = 'sha256'
    checksum64     = '9b19972e0287718d304ef7e7434973c6c880e9e25b2fa83f51f4fab412ccb9d3'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
