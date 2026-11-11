$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. $toolsDir\helpers.ps1

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'subtitleedit'
    softwareName   = 'Subtitle Edit*'
    fileType       = 'exe'
    url64bit       = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/v5.5.0-beta4/SubtitleEdit-Windows-x64-Setup.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum64     = 'e515fc0902ef604b9b3e24269193453fb8f3479066e5f17eb194aa55da38bc4d'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

$pp = Get-PackageParameters
$mergeTasks = Get-MergeTasks $pp
$packageArgs.silentArgs += ' /MERGETASKS="{0}"' -f $mergeTasks

Install-ChocolateyPackage @packageArgs
