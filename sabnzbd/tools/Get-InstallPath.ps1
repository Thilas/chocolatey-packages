function Get-InstallPath {
    [CmdletBinding()]
    param (
        [string] $packageName,
        [string] $softwareName
    )

    [array] $key = Get-UninstallRegistryKey -SoftwareName $softwareName

    if ($key.Count -eq 1) {
        $key | % {
            $file = $_.UninstallString
            if ($file) { $file = $file.Replace('"', '') }
            $file = Split-Path $file

            if ($file -and (Test-Path $file)) {
                $installPath = $file
            } else {
                Write-Warning "$packageName install not found: $file"
            }
        }
    } elseif ($key.Count -eq 0) {
        Write-Warning "$packageName install not found."
    } elseif ($key.Count -gt 1) {
        Write-Warning "$key.Count matches found!"
        Write-Warning "Please alert package maintainer the following keys were matched:"
        $key | % {Write-Warning "- $_.DisplayName"}
    }

    return $installPath
}
