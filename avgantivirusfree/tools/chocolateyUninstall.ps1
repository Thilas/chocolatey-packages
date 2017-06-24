$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageName    = 'avgantivirusfree'
$softwareName   = 'AVG Protection'
$fileType       = 'exe'
$silentArgs     = '/mode=offline /uninstall=fmw,zen,bav /silent=true'
$validExitCodes = @(0)
# *** Automatically filled ***

[array]$key = Get-UninstallRegistryKey -SoftwareName $softwareName

if ($key.Count -eq 1) {
  $key | % { 
    $file = $_.UninstallString
    if (![string]::IsNullOrEmpty($file)) { $file = $file.Replace('"', '') }
    if (![string]::IsNullOrEmpty($file)) { $file = ($file -Split ' /')[0] }

    if (![string]::IsNullOrEmpty($file) -and (Test-Path $file)) {
      Uninstall-ChocolateyPackage -PackageName $packageName `
                                  -FileType $fileType `
                                  -SilentArgs $silentArgs `
                                  -ValidExitCodes $validExitCodes `
                                  -File $file
    } else {
      Write-Warning "$packageName has already been uninstalled by other means. Unknown uninstaller: $file"
    }
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$key.Count matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $_.DisplayName"}
}
