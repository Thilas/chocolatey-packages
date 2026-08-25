$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'ComicRack Community Edition'
$version      = '0.9.184'
# *** Automatically filled ***

$info = Get-UninstallRegistryKey $softwareName
if (!$Env:ChocolateyForce -and "v$version" -eq $info.DisplayVersion) {
    Write-Host "Version $version is already installed."
    return
}


# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'comicrackce'
    softwareName   = $softwareName
    fileType       = 'exe'
    url64bit       = 'https://github.com/maforget/ComicRackCE/releases/download/v0.9.184/ComicRackCESetup_v0.9.184.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum64     = '5115e88df7f618330811599ac05b713e5e6de899daefb28b0563ce33c4d784bd'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
