$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'atom'
    fileType       = 'exe'
    url            = 'https://github.com/atom/atom/releases/download/v1.26.0-beta1/AtomSetup.exe'
    url64bit       = 'https://github.com/atom/atom/releases/download/v1.26.0-beta1/AtomSetup-x64.exe'
    silentArgs     = '--silent'
    checksum       = '04569f6520ab00b0658edb443a43ac19eded5a4d54c4b980102405de111f1959'
    checksumType   = 'sha256'
    checksum64     = '63aff8d841815c2765fd3bf77b00bdbf8e728105f6f38ab134b880268bea20d2'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
