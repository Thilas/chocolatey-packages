$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageName    = 'imdisk'
$softwareName   = 'ImDisk *'
$fileType       = 'exe'
$silentArgs     = '-y'
$validExitCodes = @(0)
# *** Automatically filled ***

function Resolve-Path {
    param ($file)
    ((Get-Location).Path + ";" + $env:PATH).Split(";") | ForEach-Object {
        if (![string]::IsNullOrEmpty($_)) {
            $path = Join-Path $_ $file
            if (Test-Path $path) { return $path }
        }
    } | Select-Object -First 1
}

[array] $key = Get-UninstallRegistryKey -SoftwareName $softwareName

if ($key.Count -eq 1) {
    $key | % { 
        $file = $_.UninstallString
        if (![string]::IsNullOrEmpty($file)) { $file = $file.Replace('"', '') }
        if (![string]::IsNullOrEmpty($file)) { $file = Resolve-Path $file }

        if (![string]::IsNullOrEmpty($file) -and (Test-Path $file)) {
            $installOverride = $env:chocolateyInstallOverride
            if (!$installOverride) {
                $env:IMDISK_SILENT_SETUP = 1
                Write-Host "Silent mode set"
            }

            # Detach all virtual disks
            $exeToRun = 'cmd.exe'
            $imdisk = Join-Path $env:SystemRoot 'System32\imdisk.exe'
            $statements = "/s /c ""if exist ""$imdisk"" for /f %a in ('imdisk -l -n') do @imdisk -D -u %~a"""
            Start-ChocolateyProcessAsAdmin -Statements $statements -ExeToRun $exeToRun -ValidExitCodes @(0, 1)

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
