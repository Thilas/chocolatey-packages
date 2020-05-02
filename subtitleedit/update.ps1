[CmdletBinding()]
param([switch] $Force)

. "$PSScriptRoot\..\Common.ps1"

function global:au_GetLatest {
    $latest = Get-GitHubLatest `
        -Repository 'SubtitleEdit/subtitleedit' `
        -FileType 'zip' `
        -IsUri32 { param($Uri) $Uri -match '\bSetup\b' } `
        -Latest @{
            SoftwareName            = 'Subtitle Edit *'
            FileType                = 'exe'
            SilentArgs              = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
            ValidExitCodes          = '0'
            UninstallFileType       = 'exe'
            UninstallSilentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
            UninstallValidExitCodes = '0'
        }
    $latest += @{ File32 = [System.IO.Path]::ChangeExtension($latest.Url32.Segments[-1], $latest.FileType) }
    "File32: {0}" -f $latest.File32 | Write-Verbose
    return $latest
}

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "^(\s*packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
            "^(\s*softwareName\s*=\s*)'.*'$"      = "`$1'$($Latest.SoftwareName)'"
            "^(\s*fileType\s*=\s*)'.*'$"          = "`$1'$($Latest.FileType)'"
            "^(\s*url\s*=\s*)'.*'$"               = "`$1'$($Latest.Url32)'"
            "^(\s*file\s*=\s*).*$"                = "`$1`"`$toolsDir\$($Latest.File32)`""
            "^(\s*silentArgs\s*=\s*)'.*'$"        = "`$1'$($Latest.SilentArgs)'"
            "^(\s*checksum\s*=\s*)'.*'$"          = "`$1'$($Latest.Checksum32)'"
            "^(\s*checksumType\s*=\s*)'.*'$"      = "`$1'$($Latest.ChecksumType32)'"
            "^(\s*validExitCodes\s*=\s*)@\(.*\)$" = "`$1@($($Latest.ValidExitCodes))"
        }
        'tools\chocolateyUninstall.ps1' = @{
            "^([$]packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
            "^([$]softwareName\s*=\s*)'.*'$"      = "`$1'$($Latest.SoftwareName)'"
            "^([$]fileType\s*=\s*)'.*'$"          = "`$1'$($Latest.UninstallFileType)'"
            "^([$]silentArgs\s*=\s*)'.*'$"        = "`$1'$($Latest.UninstallSilentArgs)'"
            "^([$]validExitCodes\s*=\s*)@\(.*\)$" = "`$1@($($Latest.UninstallValidExitCodes))"
        }
    }
}

Update-Package -ChecksumFor 32 -Force:$Force
