# IMPORTANT: Before releasing this package, copy/paste the next 2 lines into PowerShell to remove all comments from this file:
#   $f = 'C:\path\to\chocolateyUninstall.ps1'
#   gc $f | ? {$_ -notmatch "^\s*#"} | % {$_ -replace '(^.*?)\s*?[^``]#.*','$1'} | Out-File $f+".~" -en utf8; mv -fo $f+".~" $f

## NOTE: In 80-90% of the cases (95% with licensed versions due to Package Synchronizer and other enhancements), you may
## not need this file due to AutoUninstaller. See https://chocolatey.org/docs/commands-uninstall

## If this is an MSI, cleaning up comments is all you need.
## If this is an exe, change fileType and silentArgs
## Auto Uninstaller should be able to detect and handle registry uninstalls (if it is turned on, it is in preview for 0.9.9).
## - https://chocolatey.org/docs/helpers-uninstall-chocolatey-package

$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageName    = ''
$softwareName   = ''
$fileType       = ''
$silentArgs     = ''
$validExitCodes = @()
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
    $key | % {
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

        # The Product Code GUID is all that should be passed for MSI, and very
        # FIRST, because it comes directly after /x, which is already set in the
        # Uninstall-ChocolateyPackage msiargs (facepalm).
        #$silentArgs = "$($_.PSChildName) $silentArgs"

        # Don't pass anything for file, it is ignored for msi (facepalm number 2)
        # Alternatively if you need to pass a path to an msi, determine that and
        # use it instead of the above in silentArgs, still very first
        #$file = ''

        #Uninstall-ChocolateyPackage -PackageName $packageName `
        #                            -FileType $fileType `
        #                            -SilentArgs $silentArgs `
        #                            -ValidExitCodes $validExitCodes `
        #                            -File $file | Out-Null
    }
} elseif ($key.Count -eq 0) {
    Write-Warning "$packageName has already been uninstalled by other means."
} else {
    Write-Warning "$($key.Count) matches found for $packageName!"
    Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
    Write-Warning "Please contact package maintainer the following keys were matched:"
    $key | % { Write-Warning "- $($_.DisplayName)" }
}

## OTHER HELPERS
## https://chocolatey.org/docs/helpers-reference
#Uninstall-ChocolateyZipPackage $packageName # Only necessary if you did not unpack to package directory - see https://chocolatey.org/docs/helpers-uninstall-chocolatey-zip-package
#Uninstall-ChocolateyEnvironmentVariable # 0.9.10+ - https://chocolatey.org/docs/helpers-uninstall-chocolatey-environment-variable
#Uninstall-BinFile # Only needed if you used Install-BinFile - see https://chocolatey.org/docs/helpers-uninstall-bin-file
## Remove any shortcuts you added
