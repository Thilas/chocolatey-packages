$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. $toolsDir\helpers.ps1

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'subtitleedit'
    softwareName   = 'Subtitle Edit*'
    fileType       = 'exe'
    url64bit       = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/v5.0.0-beta8/SubtitleEdit-Windows-x64-Setup.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum64     = 'b5111312a9b7137d2fae0d255770f396186333d548d51b2d26204517d904d51f'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

$pp = Get-PackageParameters
$mergeTasks = Get-MergeTasks $pp
$packageArgs.silentArgs += ' /MERGETASKS="{0}"' -f $mergeTasks

Install-ChocolateyPackage @packageArgs
