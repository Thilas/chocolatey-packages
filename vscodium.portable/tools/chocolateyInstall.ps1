$ErrorActionPreference = 'Stop'

$forceX86 = if ($Env:ChocolateyForceX86) { Get-ProcessorBits 64 } else { $false }
$programFilesPath = if ($forceX86) { ${Env:ProgramFiles(x86)} } else { $Env:ProgramFiles }
$installationPath = Join-Path $programFilesPath 'VSCodium'
Write-Verbose "Installation Path: $installationPath"

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'vscodium.portable'
    url            = 'https://github.com/VSCodium/vscodium/releases/download/1.48.1/VSCodium-win32-ia32-1.48.1.zip'
    url64bit       = 'https://github.com/VSCodium/vscodium/releases/download/1.48.1/VSCodium-win32-x64-1.48.1.zip'
    unzipLocation  = $installationPath
    checksum       = '1845c1297c9ddf737aad9d05ccda8851de94ec52f7b29fc48e4890eb0412dd1d'
    checksumType   = 'sha256'
    checksum64     = '16a16652c4fe1af45fea2689b1e8000f82b51fa03b333346426a6b6f06558661'
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
