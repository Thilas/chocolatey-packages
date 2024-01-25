$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName = $Env:ChocolateyPackageName
    zipFileName = "xxx"
}
# *** Automatically filled ***

Uninstall-ChocolateyZipPackage @packageArgs
