$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'hashcheck'
    softwareName   = 'HashCheck Shell Extension'
    fileType       = 'exe'
    silentArgs     = '/S'
    validExitCodes = @(0)
}
# *** Automatically filled ***

$packageArgs.file = Get-Item ("$toolsDir\*.{0}" -f $packageArgs.fileType)

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $packageArgs.file -ErrorAction SilentlyContinue

# The installer for HashCheck puts the dll into Windows directory which breaks HashCheck
# with each Windows 10 update (see https://github.com/gurnec/HashCheck/issues/15).
# The manipulations below fix this.

$locations = @(
    # Take care of Wow64 version (if applicable) without registering an uninstaller
    @{ Source = 'SysWOW64'; Destination = ${env:ProgramFiles(x86)}; ExtraSetup = 'NoUninstall' }
    # Then take care of native version
    @{ Source = 'System32'; Destination = $env:ProgramFiles }
)

foreach ($location in $locations) {
    $oldDirectory = "$env:SystemRoot\{0}\ShellExt" -f $location.Source
    $oldPath = "$oldDirectory\HashCheck.dll"
    if (Test-Path $oldPath) {
        # Copy dll to new location
        $newDirectory = '{0}\HashCheck' -f $location.Destination
        New-Item -ItemType Directory -Path $newDirectory -Force | Out-Null
        $newPath = "$newDirectory\HashCheck.dll"
        Copy-Item $oldPath $newPath

        $exeToRun = "$env:SystemRoot\{0}\regsvr32.exe" -f $location.Source

        # Unregister and clean dll from old location
        $statements = '/u /i /n /s "{0}"' -f $oldPath
        Start-ChocolateyProcessAsAdmin -ExeToRun $exeToRun -Statements $statements -ValidExitCodes $packageArgs.validExitCodes | Out-Null
        Get-Item "$oldDirectory\HashCheck.dll.?" | Remove-Item -ErrorAction SilentlyContinue
        if (!(Get-ChildItem $oldDirectory | Select-Object -First 1)) { Remove-Item $oldDirectory -ErrorAction SilentlyContinue }

        # Register dll from new location without copying it to Windows directory
        $setups = @()
        if ($location.ExtraSetup) { $setups += $location.ExtraSetup }
        $setups += 'NoCopy'
        $statements = '/i:"{1}" /n /s "{0}"' -f $newPath, ($setups -join ' ')
        Start-ChocolateyProcessAsAdmin -ExeToRun $exeToRun -Statements $statements -ValidExitCodes $packageArgs.validExitCodes | Out-Null
    }
}
