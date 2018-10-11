$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'lavfilters'
    fileType       = 'exe'
    url            = 'https://github.com/Nevcairiel/LAVFilters/releases/download/0.73.1/LAVFilters-0.73.1-Installer.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '6cec7246e8fcd58ca77f7f74927e8d372e5a9468de73cf336d709862b75a81d3'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
