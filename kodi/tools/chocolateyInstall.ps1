$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'kodi'
    softwareName   = 'Kodi*'
    fileType       = 'exe'
    url            = 'https://mirrors.kodi.tv/releases/windows/win32/kodi-19.3-Matrix-x86.exe'
    url64bit       = 'https://mirrors.kodi.tv/releases/windows/win64/kodi-19.3-Matrix-x64.exe'
    silentArgs     = '/S'
    checksum       = '8915d4a47c27e513b14f09f134c8195edc46e1bcd5fcf3585cb78afc5db96d6f'
    checksumType   = 'sha256'
    checksum64     = '0f75ddfca90fa685b9ae5eb4f6d315b58ad7673d44937a9a399f0c5ea29a3075'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
