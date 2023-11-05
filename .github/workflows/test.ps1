$ErrorActionPreference = 'Stop'

$typeDef = @"
    using System;
    using System.Text;
    using System.Collections.Generic;
    using System.Runtime.InteropServices;

    namespace Api
    {
        public class WinStruct
        {
            public string WinTitle { get; set; }
            public int MainWindowHandle { get; set; }
        }

        public class ApiDef
        {
            private delegate bool CallBackPtr(int hwnd, int lParam);

            private static CallBackPtr _callBackPtr = Callback;
            private static List<WinStruct> _winStructList = new List<WinStruct>();

            [DllImport("User32.dll")]
            [return: MarshalAs(UnmanagedType.Bool)]
            private static extern bool EnumWindows(CallBackPtr lpEnumFunc, IntPtr lParam);

            [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
            private static extern int GetWindowText(IntPtr hWnd, StringBuilder lpString, int nMaxCount);

            private static bool Callback(int hWnd, int lparam)
            {
                var sb = new StringBuilder(256);
                var res = GetWindowText((IntPtr)hWnd, sb, 256);
                _winStructList.Add(new WinStruct { MainWindowHandle = hWnd, WinTitle = sb.ToString() });
                return true;
            }

            public static List<WinStruct> GetWindows()
            {
                _winStructList = new List<WinStruct>();
                EnumWindows(_callBackPtr, IntPtr.Zero);
                return _winStructList;
            }
        }
    }
"@
Add-Type -TypeDefinition $typeDef -Language CSharp

function Find-Window {
    <#
    .Synopsis
        user32dll.FindWindow(className, windowName)
    .Outputs
        @{
           Hwnd
           Err
        }
    .Example
        Find-Window 'ConsoleWindowClass' 'Windows PowerShell'
        Find-Window ApplicationFrameWindow 小算盤
        fWin 'ConsoleWindowClass' 'Windows PowerShell'
    .Example
        # class only
        Find-Window Notepad
    .Example
        # windowName only
        Find-Window -windowName Calculatrice
        Find-Window -windowName 小算盤
    #>
    [alias('fWin')]
    param (
        [Parameter()]
        [string]$className = "",
        [Parameter()]
        [string]$windowName = ""
    )

    $sig=@'
    // https://stackoverflow.com/a/48698671/9935654
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern IntPtr FindWindow(string lpClassName, IntPtr lpWindowName);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern IntPtr FindWindow(IntPtr lpClassName, string lpWindowName);

    [DllImport("kernel32.dll")]
    public static extern uint GetLastError();
'@

    $w32 = Add-Type -Namespace Win32 -Name Funcs -MemberDefinition $sig -PassThru
    $cName = if ($className -eq "") {[IntPtr]::Zero} else {$className}
    $wName = if ($windowName -eq "") {[IntPtr]::Zero} else {$windowName}
    $r = $w32::FindWindow($cName, $wName)
    if ($r -eq [System.IntPtr]::Zero) {
        throw [System.ComponentModel.Win32Exception]::new()
    }
    return $r
}

function Start-Program {
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    Start-Process ILSpy -LoadUserProfile -NoNewWindow -PassThru | Wait-Process -Timeout 5
    while ($true) {
        [Api.ApiDef]::GetWindows() | Where-Object WinTitle -Like ILSpy | Tee-Object -Variable w
        if ($w) {
            Find-Window -windowName 'ILSpy'
            Out-Null
            break
        }
        if ($sw.ElapsedMilliseconds -gt 5000) {
            throw "Process start timed out."
        }
        Start-Sleep -Milliseconds 100
    }
    "Started in {0}ms" -f $sw.ElapsedMilliseconds
}

function Close-Program {
    Get-Process ILSpy | Tee-Object -Variable p | Out-Host
    $p | Should -Not -BeNullOrEmpty
    $p.MainWindowHandle
    $p.refresh()
    $p.MainWindowHandle
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    $p | ForEach-Object CloseMainWindow
    Wait-Process ILSpy -Timeout 5
    "Closed in {0}ms" -f $sw.ElapsedMilliseconds
}

Start-Program
Close-Program
