$ErrorActionPreference = 'Stop'

$forceX86 = if ($Env:ChocolateyForceX86) { Get-ProcessorBits 64 } else { $false }
$programFilesPath = if ($forceX86) { ${Env:ProgramFiles(x86)} } else { $Env:ProgramFiles }
$installationPath = Join-Path $programFilesPath 'VSCodium'
Write-Verbose "Installation Path: $installationPath"

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'vscodium.portable'
    url            = 'https://github.com/VSCodium/vscodium/releases/download/1.46.0/VSCodium-win32-ia32-1.46.0.zip'
    url64bit       = 'https://github.com/VSCodium/vscodium/releases/download/1.46.0/VSCodium-win32-x64-1.46.0.zip'
    unzipLocation  = $installationPath
    checksum       = 'c2fea4e855254a373b4603ad1607f85d9c2beb3a4030c701ab3bcf65c0fc2982'
    checksumType   = 'sha256'
    checksum64     = 'ed51abe851b8de0def9fb98035664d79c898bd9adf967f2c49e29fe4c25a27d8'
    checksumType64 = 'sha256'
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

$binPath = Join-Path $installationPath 'bin\codium.cmd'
Install-BinFile -Name 'codium' -Path $binPath

$logPath = Join-Path $Env:ChocolateyPackageFolder 'vscodium.txt'
Set-Content $logPath $installationPath -Encoding UTF8 -Force

$shortcutName = 'VSCodium.lnk'
$vscodiumPath = Join-Path $installationPath 'VSCodium.exe'
$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) $shortcutName
Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath $vscodiumPath
