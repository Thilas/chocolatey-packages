$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageName    = 'hashcheck'
$validExitCodes = @(0)
# *** Automatically filled ***

$locations = @(
    # Take care of Wow64 version (if applicable)
    @{ System = 'SysWOW64'; Directory = ${env:ProgramFiles(x86)}; Optional = $true }
    # Then take care of native version
    @{ System = 'System32'; Directory = $env:ProgramFiles }
)

foreach ($location in $locations) {
    $directory = '{0}\HashCheck' -f $location.Directory
    $path = "$directory\HashCheck.dll"
    if (Test-Path $path) {
        # Unregister and clean dll
        $exeToRun = "$env:SystemRoot\{0}\regsvr32.exe" -f $location.System
        $statements = '/u /i /n /s "{0}"' -f $path
        Start-ChocolateyProcessAsAdmin -ExeToRun $exeToRun -Statements $statements -ValidExitCodes $validExitCodes | Out-Null
        Get-Item "$directory\HashCheck.dll.?" | Remove-Item -ErrorAction SilentlyContinue
        if (!(Get-ChildItem $directory | Select-Object -First 1)) { Remove-Item $directory -ErrorAction SilentlyContinue }
    } elseif (!$location.Optional) {
        Write-Host "$packageName has already been uninstalled by other means."
    }
}
