[CmdletBinding()]
param(
    [Parameter(Mandatory)] [string] $Path
)

$module = "$PSScriptRoot\..\..\chocolatey-au\src\Chocolatey-AU.psm1"
if (Test-Path $module) {
    Get-Module AU, Chocolatey-AU | Remove-Module
    Import-Module $module
} else {
    Write-Warning 'AU repository not found'
}

& $Path
