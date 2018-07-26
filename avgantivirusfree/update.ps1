[CmdletBinding()]
param([switch] $Force)

. "$PSScriptRoot\..\Common.ps1"

function global:au_GetLatest {
    $ReleaseUrl = 'http://www.avg.com/download.prd-gsr-free'
    return Get-BasicLatest -ReleaseUrl $ReleaseUrl `
                           -GetTagName { param($Release)
                               $urls = @($Release.Links | ? { $_.href -like '*.exe' -and $_.href -notlike '*x86*' -and $_.href -notlike '*x64*' })
                               if ($urls.Length -ne 1) { throw 'Tag name not found (1).' }
                               if ($urls[0].href -notmatch '_(?<TagName>\d+)\.exe') { throw 'Tag name not found (2).' }
                               $releaseFileUrl = Get-Url $ReleaseUrl $urls[0].href
                               $releaseFile = Invoke-WebRequest -Uri $releaseFileUrl -UseBasicParsing
                               $releaseDateTime = [datetime]::Parse($releaseFile.Headers['Last-Modified'])
                               $major = $releaseDateTime.Year % 100
                               $minor = $Matches.TagName
                               $build = $releaseDateTime.ToString('MMdd')
                               "$major.$minor.$build"
                           } `
                           -SkipTagName `
                           -FileType 'exe' `
                           -IsUrl32 { param($Url) $Url -like '*x86*' } `
                           -IsUrl64 { param($Url) $Url -like '*x64*' } `
                           -Latest @{
                               SilentArgs              = '/mode=offline /install=fmw,zen,bav /langid=$((Get-UICulture).LCID) /silent=true'
                               ValidExitCodes          = '0'
                               UninstallSoftwareName   = 'AVG Protection'
                               UninstallFileType       = 'exe'
                               UninstallSilentArgs     = '/mode=offline /uninstall=fmw,zen,bav /silent=true'
                               UninstallValidExitCodes = '0'
                           }
}      

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1'   = @{
            "^(\s*packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
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
            "^([$]softwareName\s*=\s*)'.*'$"      = "`$1'$($Latest.UninstallSoftwareName)'"
            "^([$]fileType\s*=\s*)'.*'$"          = "`$1'$($Latest.UninstallFileType)'"
            "^([$]silentArgs\s*=\s*)'.*'$"        = "`$1'$($Latest.UninstallSilentArgs)'"
            "^([$]validExitCodes\s*=\s*)@\(.*\)$" = "`$1@($($Latest.UninstallValidExitCodes))"
        }
    }
}

Update-Package -ChecksumFor all -Force:$Force
