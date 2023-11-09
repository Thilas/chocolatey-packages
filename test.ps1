[CmdletBinding(PositionalBinding = $false)]
param(
    [string] $Tests = $env:test_cases,
    [switch] $Inverse
)

$ErrorActionPreference = 'Stop'
if ($env:RUNNER_DEBUG) {
    $VerbosePreference = $DebugPreference = $InformationPreference = 'Continue'
}

if ($env:ChocolateyInstall) {
    $chocolateyProfile = Join-Path $env:ChocolateyInstall "helpers\chocolateyProfile.psm1"
    if (Test-Path $chocolateyProfile) {
        Import-Module $chocolateyProfile
        Update-SessionEnvironment
    }
}

# Public

function Start-Program {
    [CmdletBinding(DefaultParameterSetName = 'Default', PositionalBinding = $false)]
    param(
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string] $FilePath,
        [Parameter(Position = 1)]
        [string[]] $ArgumentList,
        [Parameter(ParameterSetName = 'Default')]
        [switch] $Shim,
        [Parameter(ParameterSetName = 'Shortcut')]
        [switch] $Shortcut,
        [switch] $SplashScreen,
        [ValidateNotNullOrEmpty()]
        [string] $ProcessName,
        [int] $TimeoutSec = 60,
        [string] $ScreenshotPrefix = $env:screenshot_prefix
    )

    if ($Shortcut) {
        $FilePath = Get-Shortcut $FilePath
    }

    "Starting $FilePath $ArgumentList..."
    Add-Screenshot $ScreenshotPrefix "start.1"
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    if ($Shortcut -and $ProcessName) {
        # Some shortcuts doesn't have an explicit target (but works anyway).
        # In such case, we need a process name to proceed.
        & $FilePath $ArgumentList
        Get-Process -Name $ProcessName | Format-Process
    } else {
        Start-Process -FilePath $FilePath -ArgumentList $ArgumentList -PassThru
        | Tee-Object -Variable initialProcess
        | Format-Process
        if ($Shim) {
            $initialProcess | Wait-Process -Timeout $TimeoutSec
        }
        if (!$ProcessName) {
            if (!$initialProcess.Name) {
                "Refreshing initial process information to get its name..."
                $initialProcess.Refresh()
            }
            $ProcessName = $initialProcess.Name
        }
    }

    $splashScreenHandles = @()
    for ($i = 1; ; $i++) {
        Start-Sleep -Milliseconds 100
        Get-Process -Name $ProcessName -ErrorAction SilentlyContinue -OutVariable processes
        | Format-Process
        if ($processes | Where-Object MainWindowHandle -NotIn 0, $splashScreenHandles) {
            if (!$SplashScreen -or $splashScreenHandles) {
                break
            }

            $splashScreenHandles = [int[]] $processes.MainWindowHandle | Where-Object { $_ -ne 0 }
            Write-Verbose "Splash screen handles: $splashScreenHandles"
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
        [string] $ScreenshotPrefix = $env:screenshot_prefix
    )

    "Closing $ProcessName..."
    Add-Screenshot $ScreenshotPrefix "close.1"
    Get-Process -Name $ProcessName -ErrorAction SilentlyContinue -OutVariable processes
    | Format-Process
    if (!$processes) {
        throw 'Cannot find a process with the name "{0}".' -f $ProcessName
    }
    if (!($processes | Where-Object MainWindowHandle -NE 0)) {
        throw 'Cannot find any windows on a process with the name "{0}".' -f $ProcessName
    }

    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    $processes.CloseMainWindow() | Write-Verbose
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

function Invoke-WebApp {
    [CmdletBinding(PositionalBinding = $false)]
    param(
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNull()]
        [uri] $Uri,
        [int] $TimeoutSec = 60
    )
    "Invoking $Uri..."
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    while ($true) {
        try {
            Invoke-WebRequest -Uri $Uri
            break
        } catch {
            if ($sw.Elapsed.TotalSeconds -gt $TimeoutSec) {
                Write-Error 'WebApp invoke timed out.' -ErrorAction Continue
                throw
            }
            "WebApp can't be reached: {0}" -f $_.Exception.Message | Write-Warning
        }
        Start-Sleep -Milliseconds 100
    }
    'Invoked in {0}ms' -f $sw.ElapsedMilliseconds
}

# Private

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
        if (!(Get-Command nircmd -ErrorAction SilentlyContinue)) {
            choco install -y --no-progress nircmd
        }
        nircmd savescreenshotfull "$Prefix.$Name.png"
    }
}

filter ConvertTo-TestCases {
    [CmdletBinding(PositionalBinding = $false)]
    param(
        [Parameter(Position = 0, ValueFromPipeline)]
        [string] $InputObject
    )
    $list = $InputObject -split '^-\s+(.+)\s*$', 0, 'Multiline'
    for ($i = 1; $i -lt $list.length - 1; $i += 2) {
        [pscustomobject] @{
            Title  = $list[$i]
            Script = $list[$i + 1].Trim() ? $list[$i + 1].Trim() : $list[$i]
        }
    }
}

filter Format-Process {
    [CmdletBinding(PositionalBinding = $false)]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
        [ValidateNotNull()]
        [System.Diagnostics.Process] $InputObject
    )
    "Process Id = {0,-10}, Name = {1,-16}, hWnd = {2,-10}" -f @(
        $InputObject.Id
        $InputObject.Name
        $InputObject.MainWindowHandle
    ) | Write-Verbose
}

function Get-Shortcut {
    [CmdletBinding(PositionalBinding = $false)]
    param(
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string] $Name
    )
    $userStartMenu   = [System.Environment]::GetFolderPath('StartMenu')
    $commonStartMenu = [System.Environment]::GetFolderPath('CommonStartMenu')
    $shortcut = Get-ChildItem $userStartMenu, $commonStartMenu -Filter *.lnk -File -Recurse
                | Where-Object BaseName -Like $Name
                | ForEach-Object FullName
    if (!$shortcut) {
        throw 'Cannot find a shortcut with the name "{0}".' -f $Name
    }
    if ($shortcut -is [array]) {
        $shortcut | Write-Verbose
        throw 'Found multiple shortcuts with the name "{0}".' -f $Name
    }
    return $shortcut
}

filter Invoke-TestCase {
    [CmdletBinding(PositionalBinding = $false)]
    param(
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string] $Title,
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string] $Script
    )
    $logs = @()
    try {
        Invoke-Expression $Script *>&1
        | ForEach-Object {
            $logs += $_
        }
        if ($LASTEXITCODE) {
            throw "Test failed with exit code $LASTEXITCODE."
        }

        if (!$Inverse) {
            Write-Outcome $Title -Success -Logs $logs
            return
        }
    } catch {
        if ($Inverse) {
            Write-Outcome $Title -Success -Logs $logs, $_
            return
        }

        Write-Outcome $Title -Logs $logs
        throw
    }

    Write-Outcome $Title -Logs $logs
    throw 'Test failed.'
}

function Write-Outcome {
    [CmdletBinding(PositionalBinding = $false)]
    param(
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string] $Title,
        [switch] $Success,
        [psobject[]] $Logs
    )
    $icon = $Success ? '✅' : '❌'
    "::group::$icon $Title"
    $Logs
    '::endgroup::'
}

$Tests
| ConvertTo-TestCases
| Invoke-TestCase
