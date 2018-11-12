$ErrorActionPreference = 'Stop'

$toolsDir     = Split-Path -parent $MyInvocation.MyCommand.Definition
$fileLocation = (Get-ChildItem -Path $toolsDir -Filter '*.exe').FullName

# *** Automatically filled ***
$InstallArgs = @{
    packageName    = 'hashcheck'
    FileType       = 'exe'
    File           = $fileLocation
    silentArgs     = "/S"
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyInstallPackage @InstallArgs
New-Item "$fileLocation.ignore" -Type file -Force | Out-Null

# The installer for HashCheck puts the DLL into the Windows directory
# which breaks HashCheck with each Windows 10 feature update.  See:
#    https://github.com/gurnec/HashCheck/issues/15
# The manipulations below should "fix" the HashCheck install.

# Move dlls
$OldPath = 'ShellExt\HashCheck.dll'
$Dllpath = "$env:ProgramFiles\HashCheck\HashCheck.dll"
$Dll32path = "${env:ProgramFiles(x86)}\HashCheck\HashCheck.dll"

if (test-path "$env:systemroot\System32\$OldPath") {
    $null = New-Item -ItemType File -Path $Dllpath -Force
    Copy-Item "$env:systemroot\System32\$OldPath" $Dllpath -Force
    Remove-Item -Path "$env:systemroot\System32\$OldPath" -Force -ErrorAction SilentlyContinue
}
if (test-path "$env:systemroot\SysWOW64\$OldPath") {
    $null = New-Item -ItemType File -Path $Dll32path -Force
    Copy-Item "$env:systemroot\SysWOW64\$OldPath" $Dll32path -Force
    Remove-Item -Path "$env:systemroot\SysWOW64\$OldPath" -Force -ErrorAction SilentlyContinue
}

# modify registry
$DefaultKeys = @(
    'hklm:\SOFTWARE\Classes\HashCheck\shell\open\command'
    'hklm:\SOFTWARE\Classes\CLSID\{705977C7-86CB-4743-BFAF-6908BD19B7B0}\InprocServer32',
    'hklm:\SOFTWARE\Classes\Wow6432Node\CLSID\{705977C7-86CB-4743-BFAF-6908BD19B7B0}\InprocServer32',
    'hklm:\SOFTWARE\Wow6432Node\Classes\CLSID\{705977C7-86CB-4743-BFAF-6908BD19B7B0}\InprocServer32'
    'hklm:\SOFTWARE\Classes\HashCheck\DefaultIcon',
)
foreach ($key in $DefaultKeys) {
    if (Test-Path $key) {
        $value = (Get-ItemProperty $key).'(Default)'
        $NewValue = $value -replace [regex]::Escape("$env:systemroot\System32\$OldPath"),$Dllpath
        $NewValue = $NewValue -replace [regex]::Escape("$env:systemroot\SysWOW64\$OldPath"),$Dll32path
        if ($value -ne $NewValue) {
            Set-ItemProperty $key -Name '(Default)' -Value $NewValue -Force
        } 
    }
}

$OtherKey = 'hklm:\SOFTWARE\Classes\HashCheck'
if (Test-Path $OtherKey) {
    $value = (Get-ItemProperty $OtherKey).FriendlyTypeName
    $NewValue = $value -replace [regex]::Escape("$env:systemroot\System32\$OldPath"),$Dllpath
    if ($value -ne $NewValue) {
        Set-ItemProperty $OtherKey -Name 'FriendlyTypeName' -Value $NewValue -Force
    }
}

$LastKey = 'hklm:HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\HashCheck Shell Extension'
if (Test-Path $LastKey) {
    $value = (Get-ItemProperty $LastKey).DisplayIcon
    $NewValue = $value -replace [regex]::Escape("$env:systemroot\System32\$OldPath"),$Dllpath
    if ($value -ne $NewValue) {
        Set-ItemProperty $LastKey -Name 'DisplayIcon' -Value $NewValue
    }

    $value = (Get-ItemProperty $LastKey).UninstallString
    $NewValue = $value -replace [regex]::Escape("$env:systemroot\System32\$OldPath"),$Dllpath
    if ($value -ne $NewValue) {
        Set-ItemProperty $LastKey -Name 'UninstallString' -Value $NewValue
    }
}

