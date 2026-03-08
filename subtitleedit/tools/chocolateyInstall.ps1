$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. $toolsDir\helpers.ps1

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'subtitleedit'
    softwareName   = 'Subtitle Edit*'
    fileType       = 'exe'
    url            = 'https://github.com/SubtitleEdit/subtitleedit/releases/download/4.0.15/SubtitleEdit-4.0.15-Setup.zip'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    checksum       = 'af9c17279b46b5e20624b99f2eec1fe376c8bc5abeeaf553fadbec588ebff22f'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

$pp = Get-PackageParameters
$mergeTasks = Get-MergeTasks $pp
$packageArgs.silentArgs += ' /MERGETASKS="{0}"' -f $mergeTasks

Install-ChocolateyPackage @packageArgs
