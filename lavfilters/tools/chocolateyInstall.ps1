$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'lavfilters'
    fileType       = 'exe'
    url            = 'https://github.com/Nevcairiel/LAVFilters/releases/download/0.73/LAVFilters-0.73-Installer.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = '9e75f3ed760d54b1e8134072971b724b4707e3eca14a90ed233ac71ab51f94ee'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
