$ErrorActionPreference = 'Stop'

$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) 'ILSpy.lnk'
if (Test-Path $shortcutPath) {
    Remove-Item $shortcutPath
}
