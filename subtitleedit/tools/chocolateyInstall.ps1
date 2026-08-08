$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. $toolsDir\helpers.ps1

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'subtitleedit'
    softwareName   = 'Subtitle Edit*'
    fileType       = 'exe'
    url64bit       = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/v5.2.0-beta7/SubtitleEdit-Windows-x64-Setup.exe'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum64     = '8ffe42098c7edb422ff208400d5d022376ec80d5b71d161658e57dad59b73690'
    checksumType64 = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

$pp = Get-PackageParameters
$mergeTasks = Get-MergeTasks $pp
$packageArgs.silentArgs += ' /MERGETASKS="{0}"' -f $mergeTasks

Install-ChocolateyPackage @packageArgs
