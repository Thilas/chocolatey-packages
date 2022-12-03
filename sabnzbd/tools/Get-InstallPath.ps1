function Get-InstallPath {
    [CmdletBinding()]
    param(
        [string] $PackageName,
        [string] $SoftwareName
    )

    [array] $key = Get-UninstallRegistryKey -SoftwareName $SoftwareName

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
            $path = if ($file) { Split-Path $file }
            if ($path) {
                return $path
            } else {
                Write-Warning "$PackageName install not found: $($_.UninstallString)"
            }
        }
    } elseif ($key.Count -eq 0) {
        Write-Warning "$PackageName install not found."
    } else {
        Write-Warning "$($key.Count) matches found for $PackageName!"
        Write-Warning "Please contact package maintainer the following keys were matched:"
        $key | ForEach-Object { Write-Warning "- $($_.DisplayName)" }
    }
}
