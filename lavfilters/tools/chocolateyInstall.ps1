$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'lavfilters'
    softwareName   = 'LAV Filters *'
    fileType       = 'exe'
    url            = 'https://github.com/Nevcairiel/LAVFilters/releases/download/0.81/LAVFilters-0.81-Installer.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = 'c00ea85173739871d2957aad3b5e0a413cc7d070d5993d3b1eb150ae91b183b3'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
