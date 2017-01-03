$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageName    = 'subtitleedit'
$softwareName   = 'Subtitle Edit *'
$fileType       = 'exe'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES'
$validExitCodes = @(0)
# *** Automatically filled ***

# Get-UninstallRegistryKey is new to 0.9.10, if supporting 0.9.9.x and below,
# take a dependency on "chocolatey-uninstall.extension" in your nuspec file.
# This is only a fuzzy search if $softwareName includes '*'. Otherwise it is 
# exact. In the case of versions in key names, we recommend removing the version
# and using '*'.
[array]$key = Get-UninstallRegistryKey -SoftwareName $softwareName

if ($key.Count -eq 1) {
  $key | % { 
    $file = $_.UninstallString
    if (![string]::IsNullOrEmpty($file)) { $file = $file.Replace('"', '') }

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
