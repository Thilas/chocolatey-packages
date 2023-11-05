[CmdletBinding(PositionalBinding = $false)]
param(
    [switch] $Inverse
)

$ErrorActionPreference = 'Stop'
if ($env:RUNNER_DEBUG) {
    $VerbosePreference = $DebugPreference = $InformationPreference = 'Continue'
}

# Public

function Invoke-Program {
    [CmdletBinding(PositionalBinding = $false)]
    param(
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string] $FilePath,
        [Parameter(Position = 1)]
        [string[]] $ArgumentList,
        [int] $TimeoutSec = 60,
        [string] $ScreenshotPrefix
    )

    Add-Screenshot $ScreenshotPrefix "invoke.1"
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    Start-Process -FilePath $FilePath -ArgumentList $ArgumentList -LoadUserProfile -NoNewWindow -PassThru
    | Tee-Object -Variable initialProcess
    | Format-Process

    try {
        $initialProcess | Wait-Process -Timeout $TimeoutSec
        if ($initialProcess.ExitCode) {
            throw "Process failed with exit code {0}." -f $initialProcess.ExitCode
        }
    } catch {
        Add-Screenshot $ScreenshotPrefix "invoke.2.failed"
        throw
    }

    'Invoked in {0}ms' -f $sw.ElapsedMilliseconds
    Add-Screenshot $ScreenshotPrefix "invoke.2.done"
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
        [string] $ProcessName,
        [switch] $Shim,
        [int] $TimeoutSec = 60,
        [string] $ScreenshotPrefix
    )

    Add-Screenshot $ScreenshotPrefix "start.1"
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    Start-Process -FilePath $FilePath -ArgumentList $ArgumentList -LoadUserProfile -PassThru
    | Tee-Object -Variable initialProcess
    | Format-Process
    if ($Shim ) {
        $initialProcess | Wait-Process -Timeout $TimeoutSec
    }
    if (!$ProcessName) {
        $ProcessName = $initialProcess.Name
    }

    for ($i = 1; ; $i++) {
        Start-Sleep -Milliseconds 100
        Get-Process -Name $ProcessName -OutVariable processes | Format-Process
        if ($processes | Where-Object MainWindowHandle -NE 0) {
            break
        }

        Add-Screenshot $ScreenshotPrefix "start.2.$i.starting"
        if ($sw.Elapsed.TotalSeconds -gt $TimeoutSec) {
            Add-Screenshot $ScreenshotPrefix "start.3.failed"
            throw 'Process start timed out.'
        }
    }

    'Started in {0}ms' -f $sw.ElapsedMilliseconds
    Add-Screenshot $ScreenshotPrefix "start.3.done"
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

    Add-Screenshot $ScreenshotPrefix "close.1"
    Get-Process -Name $ProcessName -OutVariable processes | Format-Process
    if (!$processes) {
        throw 'Cannot find a process with the name "{0}".' -f $ProcessName
    }
    if (!($processes | Where-Object MainWindowHandle -NE 0)) {
        throw 'Cannot find any windows on a process with the name "{0}".' -f $ProcessName
    }

    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    $processes.CloseMainWindow()
    Add-Screenshot $ScreenshotPrefix "close.2.closing"

    try {
        Wait-Process -Name $ProcessName -Timeout $TimeoutSec
    } catch {
        Add-Screenshot $ScreenshotPrefix "close.3.failed"
        throw
    }

    'Closed in {0}ms' -f $sw.ElapsedMilliseconds
    Add-Screenshot $ScreenshotPrefix "close.3.done"
}

# Private

filter Format-Process {
    [CmdletBinding(PositionalBinding = $false)]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
        [ValidateNotNull()]
        [System.Diagnostics.Process] $InputObject
    )
    "Process Id = {0,-10}, Name = {1,-16}, hWnd = {2,-10}" -f @(
        $InputObject.Id
        $InputObject.ProcessName
        $InputObject.MainWindowHandle
    ) | Write-Verbose
}

function Add-Screenshot {
    [CmdletBinding(PositionalBinding = $false)]
    param(
        [Parameter(Position = 0)]
        [string] $Prefix,
        [Parameter(Mandatory, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [string] $Name
    )
    if ($Prefix -and $DebugPreference -eq 'Continue') {
        if (!(Get-Command nircmd)) {
            choco install -y --no-progress nircmd
        }
        nircmd savescreenshotfull "$Prefix.$Name.png"
    }
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
