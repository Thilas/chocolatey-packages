[CmdletBinding()]
param(
    [Parameter(Mandatory)] [string] $Path
)

$module = @(
    "$PSScriptRoot\..\..\chocolatey-au\AU\AU.psm1"
    "$PSScriptRoot\..\..\chocolatey-au\src\Chocolatey-AU.psm1"
) | Where-Object { Test-Path $_ } | Select-Object -First 1
if ($module) {
    Get-Module AU, Chocolatey-AU | Remove-Module
    Import-Module $module
} else {
    Write-Warning 'AU repository not found'
}

& $Path
