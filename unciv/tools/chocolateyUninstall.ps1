$ErrorActionPreference = 'Stop'

$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) 'Unciv.lnk'
if (Test-Path $shortcutPath) {
    Remove-Item $shortcutPath
}

$installationPath = Join-Path (Get-ToolsLocation) 'Unciv'
Remove-Item $installationPath -Recurse -ErrorAction SilentlyContinue
