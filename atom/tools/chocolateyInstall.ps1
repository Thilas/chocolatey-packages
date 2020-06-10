$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'Atom'
$version      = '1.49.0-beta0'
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
    url            = 'https://github.com/atom/atom/releases/download/v1.49.0-beta0/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.49.0-beta0/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = 'e887f8435db65493fe6eb5a2ab6b297a605c89757e999cdc88aea516614fdde8'
    checksumType   = 'sha256'
    checksum64     = '1919ec61e5e9928e89a0971ed23861934d5741af0c61758339db1dd9ef76c16f'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
