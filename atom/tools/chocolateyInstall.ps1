$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = '1.42.0-beta0'
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
    url            = 'https://github.com/atom/atom/releases/download/v1.42.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.42.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = ''
    checksumType   = ''
    checksum64     = ''
    checksumType64 = ''
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
