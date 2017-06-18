$ErrorActionPreference = 'Stop'

$sysinternalsPath = 'HKCU:\SOFTWARE\Sysinternals'
$applicationName = 'Process Monitor'
If (Test-Path $sysinternalsPath) {
  If (@(Get-ItemProperty $sysinternalsPath).Count -eq 0 -and @(Get-ChildItem $sysinternalsPath -Exclude $applicationName).Count -eq 0) {
    Remove-Item $sysinternalsPath -Recurse -Force
  } ElseIf (Test-Path "$sysinternalsPath\$applicationName") {
    Remove-Item "$sysinternalsPath\$applicationName" -Recurse -Force
  }
}

$shortcutPath = Join-Path $([Environment]::GetFolderPath('CommonPrograms')) 'Process Monitor.lnk'
If (Test-Path $shortcutPath) {
  Remove-Item $shortcutPath
}
