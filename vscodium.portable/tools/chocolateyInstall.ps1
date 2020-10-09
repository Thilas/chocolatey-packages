$ErrorActionPreference = 'Stop'

$forceX86 = if ($Env:ChocolateyForceX86) { Get-ProcessorBits 64 } else { $false }
$programFilesPath = if ($forceX86) { ${Env:ProgramFiles(x86)} } else { $Env:ProgramFiles }
$installationPath = Join-Path $programFilesPath 'VSCodium'
Write-Verbose "Installation Path: $installationPath"

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'vscodium.portable'
    url            = 'https://github.com/VSCodium/vscodium/releases/download/1.50.0/VSCodium-win32-ia32-1.50.0.zip'
    url64bit       = 'https://github.com/VSCodium/vscodium/releases/download/1.50.0/VSCodium-win32-x64-1.50.0.zip'
    unzipLocation  = $installationPath
    checksum       = 'ee49818b96d78a9acf712c44167b6e579b97b09c7c1e5b079d17b900188f95a6'
    checksumType   = 'sha256'
    checksum64     = 'ec75f6bfc48a5c6306967b14003b59f108dcb4edd1f83a103c5eb4f3458bfb6f'
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
