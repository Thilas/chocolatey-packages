$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = '1.43.0-beta0'
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
    url            = 'https://github.com/atom/atom/releases/download/v1.43.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.43.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = 'b17cf82b06a23287637cf4ca316b4695cfcfa23caaa5a3860c5ce49ddb5e9b35'
    checksumType   = 'sha256'
    checksum64     = '738478a32777f610fb1cffc4f795a6c0c0ab53283a609b4bc0832c8cda382f0c'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
