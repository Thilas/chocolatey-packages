$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageName  = 'imdisk'
$softwareName = 'ImDisk *'
# *** Automatically filled ***

[array] $key = Get-UninstallRegistryKey -SoftwareName $softwareName

if ($key.Count -eq 1) {
    $key | ForEach-Object {
        $packageArgs = @{
            packageName    = $packageName
            fileType       = 'exe'
            file           = "$Env:SystemRoot\System32\cmd.exe"
            silentArgs     = '/c "{0}"' -f $_.UninstallString
            validExitCodes = @(0)
        }

        # Dismount all existing ImDisk virtual disks
        if (Test-Path "$Env:SystemRoot\System32\imdisk.exe") {
            $statements = '/c "for /f %a in (''imdisk -l -n'') do @imdisk -l -u %~a & @imdisk -D -u %~a"'
            Start-ChocolateyProcessAsAdmin -ExeToRun $packageArgs.file -Statements $statements -ValidExitCodes @(0, 1) | Out-Null
        }

        $Env:IMDISK_SILENT_SETUP = 1

        Uninstall-ChocolateyPackage @packageArgs | Out-Null
    }
} elseif ($key.Count -eq 0) {
    Write-Warning "$packageName has already been uninstalled by other means."
} else {
    Write-Warning "$($key.Count) matches found for $packageName!"
    Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
    Write-Warning "Please contact package maintainer the following keys were matched:"
    $key | ForEach-Object { Write-Warning "- $($_.DisplayName)" }
}
