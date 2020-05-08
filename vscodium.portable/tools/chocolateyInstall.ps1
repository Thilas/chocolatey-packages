$ErrorActionPreference = 'Stop'

$forceX86 = if ($Env:ChocolateyForceX86) { Get-ProcessorBits 64 } else { $false }
$programFilesPath = if ($forceX86) { ${Env:ProgramFiles(x86)} } else { $Env:ProgramFiles }
$installationPath = Join-Path $programFilesPath 'VSCodium'
Write-Verbose "Installation Path: $installationPath"

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'vscodium.portable'
    url            = 'https://github.com/VSCodium/vscodium/releases/download/1.45.0/VSCodium-win32-ia32-1.45.0.zip'
    url64bit       = 'https://github.com/VSCodium/vscodium/releases/download/1.45.0/VSCodium-win32-x64-1.45.0.zip'
    unzipLocation  = $installationPath
    checksum       = '46bd6084fad310b6b5eb4f8906516bf7b9a0c112bf74609786dcf1918af74276'
    checksumType   = 'sha256'
    checksum64     = '65fae1d3a1ca4dc2d9e4f4ca1142fe89063357ae96acdc9c0d7c7b344d01a564'
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
