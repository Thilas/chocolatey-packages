$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. $toolsDir\helpers.ps1

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'subtitleedit'
    softwareName   = 'Subtitle Edit*'
    fileType       = 'exe'
    url64bit       = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/v5.1.0-beta2/SubtitleEdit-Windows-x64-Setup.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum64     = 'da806dd0a50657d36f88ea935512f4ec346d355f737dbde85956d69fbb271509'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

$pp = Get-PackageParameters
$mergeTasks = Get-MergeTasks $pp
$packageArgs.silentArgs += ' /MERGETASKS="{0}"' -f $mergeTasks

Install-ChocolateyPackage @packageArgs
