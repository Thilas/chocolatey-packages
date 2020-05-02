[CmdletBinding()]
param($IncludeStream, [switch] $Force)

. "$PSScriptRoot\..\Common.ps1"

function global:au_GetLatest {
    # 5.10 streams and below only have 32bit installers
    Get-LinksLatest `
        -ReleasesUri 'http://strawberryperl.com/releases.html' `
        -FileType 'msi' `
        -IsLink { param($Link) $Link.onclick } `
        -GetVersion { param($Link)
            $value = if ($Link.href -match '-(?<Version>\d+(?:\.\d+){1,3})') {
                $Matches.Version
            } else {
                $Link.href
            }
            Get-Version $value
        } `
        -StreamFieldCount 2 `
        -IsUri32 { param($Uri) $Uri -notmatch '\b64bit\b' } `
        -IsUri64 { param($Uri, $Version) $Uri -match '\b64bit\b' -or $Version -lt '5.11' } `
        -Latest @{
            SoftwareName   = 'Strawberry Perl *'
            SilentArgs     = '/qn /norestart'
            ValidExitCodes = '0, 3010, 1641'
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
            "^(\s*silentArgs\s*=\s*)'.*'$"        = "`$1'$($Latest.SilentArgs)'"
            "^(\s*checksum\s*=\s*)'.*'$"          = "`$1'$($Latest.Checksum32)'"
            "^(\s*checksumType\s*=\s*)'.*'$"      = "`$1'$($Latest.ChecksumType32)'"
            "^(\s*checksum64\s*=\s*)'.*'$"        = "`$1'$($Latest.Checksum64)'"
            "^(\s*checksumType64\s*=\s*)'.*'$"    = "`$1'$($Latest.ChecksumType64)'"
            "^(\s*validExitCodes\s*=\s*)@\(.*\)$" = "`$1@($($Latest.ValidExitCodes))"
        }
    }
}

Update-Package -ChecksumFor all -IncludeStream $IncludeStream -Force:$Force
