$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$softwareName = 'ComicRack Community Edition'
$version      = '0.9.182'
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
    url64bit       = 'https://github.com/maforget/ComicRackCE/releases/download/v0.9.182/ComicRackCESetup_v0.9.182.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum64     = 'df9a5d9ccab86508400990f1c4b8f8e3580e478bec4eac3d3d8adcb880617100'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
