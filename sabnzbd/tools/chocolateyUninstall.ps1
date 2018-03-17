$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageName    = 'sabnzbd'
$softwareName   = 'SABnzbd*'
$fileType       = 'exe'
$silentArgs     = '/S'
$validExitCodes = @(0)
# *** Automatically filled ***

[array] $key = Get-UninstallRegistryKey -SoftwareName $softwareName

if ($key.Count -eq 1) {
    $key | % { 
        if ($_.UninstallString) {
            function Split-CommandLine {
                param([string] $file)
                return $file
            }
            # Remove quotes and trailing arguments if any
            $file = Invoke-Expression "Split-CommandLine $($_.UninstallString)"
        }

        if ($file -and (Test-Path $file)) {
            Uninstall-ChocolateyPackage -PackageName $packageName `
                                        -FileType $fileType `
                                        -SilentArgs $silentArgs `
                                        -ValidExitCodes $validExitCodes `
                                        -File $file
        } else {
            Write-Warning "$packageName has already been uninstalled by other means. Unknown uninstaller: $file ($($_.UninstallString))."
        }
    }
} elseif ($key.Count -eq 0) {
    Write-Warning "$packageName has already been uninstalled by other means."
} else {
    Write-Warning "$($key.Count) matches found for $packageName!"
    Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
    Write-Warning "Please contact package maintainer the following keys were matched:"
    $key | % { Write-Warning "- $($_.DisplayName)" }
}
