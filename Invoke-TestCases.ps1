[CmdletBinding()]
param(
    [switch] $Inverse
)

if ($env:debug) {
    $VerbosePreference = $DebugPreference = $InformationPreference = 'Continue'
}

function Write-Outcome {
    [CmdletBinding()]
    param(
        [string] $TestCase,
        [switch] $Success,
        [psobject[]] $Logs
    )
    $icon = $Success ? "✅" : "❌"
    "::group::$icon $TestCase"
    $Logs
    '::endgroup::'
}

$testCases = $env:test_cases -split '^-\s+(.+)\s*$', 0, 'Multiline'
for ($i = 1; $i -lt $testCases.length - 1; $i += 2) {
    $logs = @()
    try {
        Invoke-Expression $testCases[$i + 1] *>&1 `
        | ForEach-Object {
            $logs += $_
        }
        if ($LASTEXITCODE) {
            throw "Test failed with exit code $LASTEXITCODE."
        }

        if (!$Inverse) {
            Write-Outcome -TestCase $testCases[$i] -Success -Logs $logs
            continue
        }
    } catch {
        if ($Inverse) {
            Write-Outcome -TestCase $testCases[$i] -Success -Logs $logs, $_
            continue
        }

        Write-Outcome -TestCase $testCases[$i] -Logs $logs
        throw
    }

    Write-Outcome -TestCase $testCases[$i] -Logs $logs
    throw "Test failed."
}
