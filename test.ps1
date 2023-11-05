[CmdletBinding(PositionalBinding = $false)]
param(
    [switch] $Inverse
)

$VerbosePreference = 'Continue'
if ($env:RUNNER_DEBUG) {
    $VerbosePreference = $DebugPreference = $InformationPreference = 'Continue'
}

function Start-Program {
    [CmdletBinding(PositionalBinding = $false)]
    param(
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string] $FilePath,
        [Parameter(Position = 1)]
        [string[]] $ArgumentList,
        [ValidateNotNullOrEmpty()]
        [string] $ProcessName = $FilePath,
        [int] $TimeoutSec = 60,
        [string] $ScreenshotPrefix
    )

    if ($ScreenshotPrefix) { nircmd savescreenshotfull "$ScreenshotPrefix.1.start.png" }

    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    Start-Process -FilePath $FilePath -ArgumentList $ArgumentList -LoadUserProfile -PassThru -OutVariable processes
    Write-Verbose "MainWindowHandle(s): $($processes.MainWindowHandle -join ', ')"

    $i = 1
    while ($true) {
        if ($processes | Where-Object MainWindowHandle -NE [System.IntPtr]::Zero) {
            break
        }

        if ($ScreenshotPrefix -and $DebugPreference -eq 'Continue') { nircmd savescreenshotfull "$ScreenshotPrefix.2.$i.starting.png" }
        if ($sw.Elapsed.TotalSeconds -gt $TimeoutSec) {
            if ($ScreenshotPrefix) { nircmd savescreenshotfull "$ScreenshotPrefix.3.failed.png" }
            throw 'Process start timed out.'
        }

        Start-Sleep -Milliseconds 100
        Get-Process -Name $ProcessName -OutVariable processes
        Write-Verbose "MainWindowHandle(s): $($processes.MainWindowHandle -join ', ')"
        $i++
    }

    'Started in {0}ms' -f $sw.ElapsedMilliseconds
    if ($ScreenshotPrefix) { nircmd savescreenshotfull "$ScreenshotPrefix.3.started.png" }
}

function Close-Program {
    [CmdletBinding(PositionalBinding = $false)]
    param(
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string] $ProcessName,
        [int] $TimeoutSec = 60,
        [string] $ScreenshotPrefix
    )

    if ($ScreenshotPrefix) { nircmd savescreenshotfull "$ScreenshotPrefix.4.close.png" }

    Get-Process -Name $ProcessName -OutVariable processes
    if (!$processes) {
        throw 'Cannot find a process with the name "{0}".' -f $ProcessName
    }
    if (!($processes | Where-Object MainWindowHandle -NE [System.IntPtr]::Zero)) {
        throw 'Cannot find any window on processes with the name "{0}".' -f $ProcessName
    }

    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    Write-Verbose "MainWindowHandle(s): $($processes.MainWindowHandle -join ', ')"
    $processes.CloseMainWindow()
    if ($ScreenshotPrefix -and $DebugPreference -eq 'Continue') { nircmd savescreenshotfull "$ScreenshotPrefix.5.closing.png" }

    try {
        Wait-Process -Name $ProcessName -Timeout $TimeoutSec
    } catch {
        if ($ScreenshotPrefix) { nircmd savescreenshotfull "$ScreenshotPrefix.6.failed.png" }
        throw
    }

    'Closed in {0}ms' -f $sw.ElapsedMilliseconds
    if ($ScreenshotPrefix) { nircmd savescreenshotfull "$ScreenshotPrefix.6.closed.png" }
}

function Write-Outcome {
    [CmdletBinding(PositionalBinding = $false)]
    param(
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string] $TestCase,
        [switch] $Success,
        [psobject[]] $Logs
    )
    $icon = $Success ? '✅' : '❌'
    "::group::$icon $TestCase"
    $Logs
    '::endgroup::'
}

$testCases = $env:test_cases -split '^-\s+(.+)\s*$', 0, 'Multiline'
for ($i = 1; $i -lt $testCases.length - 1; $i += 2) {
    $logs = @()
    try {
        Invoke-Expression $testCases[$i + 1] *>&1
        | ForEach-Object {
            $logs += $_
        }
        if ($LASTEXITCODE) {
            throw "Test failed with exit code $LASTEXITCODE."
        }

        if (!$Inverse) {
            Write-Outcome $testCases[$i] -Success -Logs $logs
            continue
        }
    } catch {
        if ($Inverse) {
            Write-Outcome $testCases[$i] -Success -Logs $logs, $_
            continue
        }

        Write-Outcome $testCases[$i] -Logs $logs
        throw
    }

    Write-Outcome $testCases[$i] -Logs $logs
    throw 'Test failed.'
}
