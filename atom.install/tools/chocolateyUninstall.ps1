$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageName    = 'atom.install'
$softwareName   = 'Atom'
$fileType       = 'exe'
$silentArgs     = '--uninstall --silent'
$validExitCodes = @(0)
# *** Automatically filled ***

[array] $key = Get-UninstallRegistryKey -SoftwareName $softwareName

if ($key.Count -eq 1) {
    function Get-File ([string] $path) {
        # Remove quotes and trailing arguments if any
        if (!$path) { return }
        if (Test-Path $path) { return $path }
        function Split-CommandLine ([string] $path) { $path }
        $path = Invoke-Expression "Split-CommandLine $path"
        if (Test-Path $path) { return $path }
    }
    $key | ForEach-Object {
        $file = Get-File $_.UninstallString
        if ($file) {
            Uninstall-ChocolateyPackage -PackageName $packageName `
                                        -FileType $fileType `
                                        -SilentArgs $silentArgs `
                                        -ValidExitCodes $validExitCodes `
                                        -File $file | Out-Null
        } else {
            Write-Warning "Unknown uninstaller: $($_.UninstallString)"
        }
    }
} elseif ($key.Count -eq 0) {
    Write-Warning "$packageName has already been uninstalled by other means."
} else {
    Write-Warning "$($key.Count) matches found for $packageName!"
    Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
    Write-Warning "Please contact package maintainer the following keys were matched:"
    $key | ForEach-Object { Write-Warning "- $($_.DisplayName)" }
}
