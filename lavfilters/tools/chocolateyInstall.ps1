$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'lavfilters'
    softwareName   = 'LAV Filters *'
    fileType       = 'exe'
    url            = 'https://github.com/Nevcairiel/LAVFilters/releases/download/0.77/LAVFilters-0.77-Installer.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '9a9ab8122565199268247f2ad821fc0d6bbcc53d0e553b94e57f7c7d55c07b48'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
