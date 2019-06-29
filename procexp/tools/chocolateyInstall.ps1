$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'procexp'
    url            = 'https://download.sysinternals.com/files/ProcessExplorer.zip'
    unzipLocation  = $toolsDir
    checksum       = 'dc422a6ca2872207e8d0ef55ba4291998c8923efe847ba9e025c610090ad20be'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

@('procexp', 'procexp64') | % {
    New-Item "$toolsDir\$_.exe.gui" -Type File -Force | Out-Null
}

New-Item 'HKCU:\SOFTWARE\Sysinternals\Process Explorer' -Force | New-ItemProperty -Name 'EulaAccepted' -Value 1 -Force | Out-Null

$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) 'Process Explorer.lnk'
if (-not (Test-Path $shortcutPath)) {
    $targetPath = if ([Environment]::Is64BitOperatingSystem) { 'procexp64.exe' } else { 'procexp.exe' }
    Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath "$toolsDir\$targetPath"
}
