[CmdletBinding()]
param(
    [switch] $Inverse
)

$ErrorActionPreference = 'Stop'
$env:test_cases = @'
- Start program
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    Start-Process ILSpy -LoadUserProfile -PassThru | Tee-Object -Variable p
    "MainWindowHandle: {0}" -f $p.MainWindowHandle
    # Find-Window ILSpy | Tee-Object -Variable w
    $i = 1
    while ($p.MainWindowHandle -eq [System.IntPtr]::Zero) {
        nircmd savescreenshotfull "desktop.starting.$i.png"
        if ($sw.ElapsedMilliseconds -gt 10000) {
            throw "Process start timed out."
        }
        Start-Sleep -Milliseconds 500
        Get-Process ILSpy | Tee-Object -Variable p
        "MainWindowHandle: {0}" -f $p.MainWindowHandle
        # Find-Window ILSpy | Tee-Object -Variable w
        $i++
    }
    # $p.WaitForInputIdle()
    # "MainWindowHandle: {0}" -f $p.MainWindowHandle
    "Started in {0}ms" -f $sw.ElapsedMilliseconds
    nircmd savescreenshotfull "desktop.started.png"
- Close program
    Get-Process ILSpy | Tee-Object -Variable p
    $p | Should -Not -BeNullOrEmpty
    "MainWindowHandle: {0}" -f $p.MainWindowHandle
    # Find-Window ILSpy | Tee-Object -Variable w
    # $w | Should -Not -BeNullOrEmpty
    nircmd savescreenshotfull "desktop.closing.png"
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    $p.CloseMainWindow()
    # Close-Window $w
    try {
        Wait-Process ILSpy -Timeout 10
    } catch {
        nircmd savescreenshotfull "desktop.failed.png"
        throw
    }
    "Closed in {0}ms" -f $sw.ElapsedMilliseconds
    nircmd savescreenshotfull "desktop.closed.png"
'@

if ($env:debug) {
    $VerbosePreference = $DebugPreference = $InformationPreference = 'Continue'
}

$code = @'
[DllImport("user32.dll", CharSet = CharSet.Auto)]
public static extern IntPtr FindWindow(IntPtr lpClassName, string lpWindowName);

[DllImport("user32.dll", CharSet = CharSet.Auto)]
public static extern IntPtr SendMessage(IntPtr hWnd, uint Msg, nuint wParam, nint lParam);

public const int WM_SYSCOMMAND = 0x0112;
public const int SC_CLOSE = 0xF060;
'@
$win32 = Add-Type -Namespace Win32 -Name API -MemberDefinition $code -PassThru

function Find-Window([string] $Name) {
    $hWnd = $win32::FindWindow([System.IntPtr]::Zero, $Name)
    return $hWnd -ne [System.IntPtr]::Zero ? $hwnd : $null
}

function Close-Window([System.IntPtr] $hWnd) {
    $win32::SendMessage($hWnd, $win32::WM_SYSCOMMAND, $win32::SC_CLOSE, 0)
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
