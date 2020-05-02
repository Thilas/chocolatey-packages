[CmdletBinding()]
param([switch] $Force)

. "$PSScriptRoot\..\Common.ps1"

function global:au_GetLatest {
    Get-BasicLatest `
        -ReleaseUri 'http://www.avg.com/download.prd-gsr-free' `
        -GetTagName { param($Release)
            $uri = $Release.Links `
            | Where-Object 'href' -Like '*.exe' `
            | Get-Uri `
            | Where-Object { $_.href -notmatch '\bx86\b' -and $_.href -notmatch '\bx64\b' } `
            | Assert-Uri -Name 'Tag name'
            $response = Invoke-WebRequest -Uri $uri -UseBasicParsing -Method Head
            $response.BaseResponse.LastModified.ToString('yy.MM.dd')
        } `
        -FileType 'exe' `
        -SkipTagName `
        -IsUri32 { param($Uri) $Uri -match '\bx86\b' } `
        -IsUri64 { param($Uri) $Uri -match '\bx64\b' } `
        -Latest @{
            SoftwareName            = 'AVG Protection'
            SilentArgs              = '/mode=offline /install=fmw,zen,bav /langid=$((Get-UICulture).LCID) /silent=true'
            ValidExitCodes          = '0'
            UninstallFileType       = 'exe'
            UninstallSilentArgs     = '/mode=offline /uninstall=fmw,zen,bav /silent=true'
            UninstallValidExitCodes = '0'
        }
}

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "^(\s*packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
            "^(\s*softwareName\s*=\s*)'.*'$"      = "`$1'$($Latest.SoftwareName)'"
            "^(\s*fileType\s*=\s*)'.*'$"          = "`$1'$($Latest.FileType)'"
            "^(\s*url\s*=\s*)'.*'$"               = "`$1'$($Latest.Url32)'"
            "^(\s*url64bit\s*=\s*)'.*'$"          = "`$1'$($Latest.Url64)'"
            "^(\s*silentArgs\s*=\s*)"".*""$"      = "`$1""$($Latest.SilentArgs)"""
            "^(\s*checksum\s*=\s*)'.*'$"          = "`$1'$($Latest.Checksum32)'"
            "^(\s*checksumType\s*=\s*)'.*'$"      = "`$1'$($Latest.ChecksumType32)'"
            "^(\s*checksum64\s*=\s*)'.*'$"        = "`$1'$($Latest.Checksum64)'"
            "^(\s*checksumType64\s*=\s*)'.*'$"    = "`$1'$($Latest.ChecksumType64)'"
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

Update-Package -ChecksumFor all -Force:$Force
