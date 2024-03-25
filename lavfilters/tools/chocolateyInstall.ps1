$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'lavfilters'
    softwareName   = 'LAV Filters *'
    fileType       = 'exe'
    url            = 'https://github.com/Nevcairiel/LAVFilters/releases/download/0.79/LAVFilters-0.79-Installer.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '47c875faaf0ecac0da629c1b93b6c96b42122bdb8e513427808c2f7e161d1f41'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
