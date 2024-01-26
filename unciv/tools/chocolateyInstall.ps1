$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$installationPath = Join-Path (Get-ToolsLocation) 'Unciv'

# *** Automatically filled ***
$packageArgs = @{
    packageName = $Env:ChocolateyPackageName
    file64      = "$toolsDir\Unciv-Windows64.zip"
    destination = $installationPath
}
# *** Automatically filled ***

Get-ChocolateyUnzip @packageArgs
Remove-Item $packageArgs.file64 -ErrorAction SilentlyContinue

$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) 'Unciv.lnk'
if (!(Test-Path $shortcutPath)) {
    Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath "$installationPath\Unciv.exe"
}
