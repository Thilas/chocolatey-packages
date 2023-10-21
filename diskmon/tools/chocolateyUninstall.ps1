$ErrorActionPreference = 'Stop'

$sysinternalsPath = 'HKCU:\SOFTWARE\Sysinternals'
$applicationName = 'Diskmon'
if (Test-Path $sysinternalsPath) {
    if (@(Get-ItemProperty $sysinternalsPath).Count -eq 0 -and @(Get-ChildItem $sysinternalsPath -Exclude $applicationName).Count -eq 0) {
        Remove-Item $sysinternalsPath -Recurse -Force
    } elseif (Test-Path "$sysinternalsPath\$applicationName") {
        Remove-Item "$sysinternalsPath\$applicationName" -Recurse -Force
    }
}

$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) 'DiskMon.lnk'
if (Test-Path $shortcutPath) {
    Remove-Item $shortcutPath
}
