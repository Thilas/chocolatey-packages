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

$OldPath = 'ShellExt\HashCheck.dll'
$NewDllpath = Join-Path $env:ProgramFiles 'HashCheck\HashCheck.dll'
$NewDll32path = Join-Path ${env:ProgramFiles(x86)} 'HashCheck\HashCheck.dll'

# Move the sysnative version
if (Test-Path "$env:systemroot\System32\$OldPath") {
   if (-not (Test-Path (Split-Path $NewDllpath))) {
      $null = New-Item -ItemType Directory -Path (Split-Path $NewDllpath) -Force
   }
   Copy-Item "$env:systemroot\System32\$OldPath" $NewDllpath -Force
   Remove-Item -Path "$env:systemroot\System32\$OldPath" -Force -ErrorAction SilentlyContinue
}

# Then the 32-bit version on 64-bit systems
if (Test-Path "$env:systemroot\SysWOW64\$OldPath") {
   if (-not (Test-Path (Split-Path $NewDll32path))) {
      $null = New-Item -ItemType Directory -Path (Split-Path $NewDll32path) -Force
   }
   Copy-Item "$env:systemroot\SysWOW64\$OldPath" $NewDll32path -Force
   Remove-Item -Path "$env:systemroot\SysWOW64\$OldPath" -Force -ErrorAction SilentlyContinue
}

# modify registry
$DefaultKeys = @(
    'hklm:\SOFTWARE\Classes\HashCheck\shell\open\command'
    'hklm:\SOFTWARE\Classes\CLSID\{705977C7-86CB-4743-BFAF-6908BD19B7B0}\InprocServer32',
    'hklm:\SOFTWARE\Classes\Wow6432Node\CLSID\{705977C7-86CB-4743-BFAF-6908BD19B7B0}\InprocServer32',
    'hklm:\SOFTWARE\Wow6432Node\Classes\CLSID\{705977C7-86CB-4743-BFAF-6908BD19B7B0}\InprocServer32'
    'hklm:\SOFTWARE\Classes\HashCheck\DefaultIcon'
)
foreach ($key in $DefaultKeys) {
    if (Test-Path $key) {
        $value = (Get-ItemProperty $key).'(Default)'
        $NewValue = $value -replace [regex]::Escape("$env:systemroot\System32\$OldPath"),$NewDllpath
        $NewValue = $NewValue -replace [regex]::Escape("$env:systemroot\SysWOW64\$OldPath"),$NewDll32path
        if ($value -ne $NewValue) {
            Set-ItemProperty $key -Name '(Default)' -Value $NewValue -Force
        } 
    }
}

$OtherKey = 'hklm:\SOFTWARE\Classes\HashCheck'
if (Test-Path $OtherKey) {
    $value = (Get-ItemProperty $OtherKey).FriendlyTypeName
    $NewValue = $value -replace [regex]::Escape("$env:systemroot\System32\$OldPath"),$NewDllpath
    if ($value -ne $NewValue) {
        Set-ItemProperty $OtherKey -Name 'FriendlyTypeName' -Value $NewValue -Force
    }
}

$UninstallKey = 'hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\HashCheck Shell Extension'
if (Test-Path $UninstallKey) {
   Set-ItemProperty $UninstallKey -Name 'DisplayIcon' -Value $NewDllpath -Force
   $UninstallString = "regsvr32.exe /u /i /n `"$NewDllpath`""
   Set-ItemProperty $UninstallKey -Name 'UninstallString' -Value $UninstallString -Force

   $QuietUninstallString = $UninstallString -replace ' /u ',' /s /u '
   Set-ItemProperty $UninstallKey -Name 'QuietUninstallString' -Value $QuietUninstallString -Force
}

