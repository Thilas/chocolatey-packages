$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName = $Env:ChocolateyPackageName
    zipFileName = "Unciv-Windows64.zip"
}
# *** Automatically filled ***

Uninstall-ChocolateyZipPackage @packageArgs
