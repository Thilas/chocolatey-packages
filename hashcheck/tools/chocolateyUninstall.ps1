$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageName    = 'hashcheck'
$validExitCodes = @(0)
# *** Automatically filled ***

$locations = @(
    # Take care of Wow64 version (if applicable)
    @{ System = 'SysWOW64'; Directory = ${Env:ProgramFiles(x86)}; Optional = $true }
    # Then take care of native version
    @{ System = 'System32'; Directory = $Env:ProgramFiles }
)

$locations | ForEach-Object {
    $directory = '{0}\HashCheck' -f $_.Directory
    $path = "$directory\HashCheck.dll"
    if (Test-Path $path) {
        # Unregister and clean dll
        $exeToRun = "$Env:SystemRoot\{0}\regsvr32.exe" -f $_.System
        $statements = '/u /i /n /s "{0}"' -f $path
        Start-ChocolateyProcessAsAdmin -ExeToRun $exeToRun -Statements $statements -ValidExitCodes $validExitCodes | Out-Null
        Get-Item "$directory\HashCheck.dll.?" | Remove-Item -ErrorAction SilentlyContinue
        if (!(Get-ChildItem $directory | Select-Object -First 1)) { Remove-Item $directory -ErrorAction SilentlyContinue }
    } elseif (!$_.Optional) {
        Write-Host "$packageName has already been uninstalled by other means."
    }
}
