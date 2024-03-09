[CmdletBinding()]
param(
    [Parameter(Mandatory)] [string] $Path
)

$module = "$PSScriptRoot\..\..\majkinetor\au\AU"
if (Test-Path $module) {
    Get-Module AU | Remove-Module
    Import-Module $module
} else {
    Write-Warning 'AU repository not found'
}

& $Path
