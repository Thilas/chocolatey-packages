$ErrorActionPreference = 'Stop'

$forceX86 = if ($Env:ChocolateyForceX86) { Get-ProcessorBits 64 } else { $false }
$programFilesPath = if ($forceX86) { ${Env:ProgramFiles(x86)} } else { $Env:ProgramFiles }
$installationPath = Join-Path $programFilesPath 'VSCodium'
Write-Verbose "Installation Path: $installationPath"

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'vscodium.portable'
    url            = 'https://github.com/VSCodium/vscodium/releases/download/1.45.1/VSCodium-win32-ia32-1.45.1.zip'
    url64bit       = 'https://github.com/VSCodium/vscodium/releases/download/1.45.1/VSCodium-win32-x64-1.45.1.zip'
    unzipLocation  = $installationPath
    checksum       = '0b66667b1bbb02b9a3416853de40ea0cde82c433773e08e326b4a96567de1bda'
    checksumType   = 'sha256'
    checksum64     = 'add6a7c682c75d62d9ed8bb7bcb6dd281a01a261c038cbd5727f224fa6d7fd5a'
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
