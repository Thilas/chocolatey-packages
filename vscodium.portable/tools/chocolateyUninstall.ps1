$ErrorActionPreference = 'Stop'

$shortcutName = 'VSCodium.lnk'
$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) $shortcutName
Remove-Item $shortcutPath -ErrorAction SilentlyContinue -Force

$logPath = Join-Path $Env:ChocolateyPackageFolder 'vscodium.txt'
$installationPath = Get-Content $logPath
Write-Verbose "Previous Installation Path: $installationPath"

Uninstall-BinFile -Name 'codium'

Remove-Item -Path $installationPath -ErrorAction SilentlyContinue -Recurse -Force
