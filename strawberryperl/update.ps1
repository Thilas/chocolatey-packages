[CmdletBinding()]
param($IncludeStream, [switch] $Force)

. "$PSScriptRoot\..\Common.ps1"

function global:au_GetLatest {
    Get-GitHubLatest `
        -Repository 'StrawberryPerl/Perl-Dist-Strawberry' `
        -ReleaseFilter { param($Release)
            $Release.tag_name -notlike 'dev_*' -and $Release.tag_name -ne 'patched_cpan_modules'
        } `
        -GetTagName { param($Release)
            $version = Get-Version $Release.name -Delimiter ' '
            if (($version.Version.Minor % 2) -eq 1 -and !$version.Prerelease) {
                # Odd versions are for tests, so let's make it a prerelease
                $version.Prerelease = 'test'
            }
            return $version
        } `
        -StreamFieldCount 2 `
        -FileType 'msi' `
        -IsUri64 { param($Uri, $Version) $Uri -match '\b64bit\b' -and $Uri -like "*$($Version.Version)*" } `
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
            "^(\s*url64bit\s*=\s*)'.*'$"          = "`$1'$($Latest.Url64)'"
            "^(\s*silentArgs\s*=\s*)'.*'$"        = "`$1'$($Latest.SilentArgs)'"
            "^(\s*checksum64\s*=\s*)'.*'$"        = "`$1'$($Latest.Checksum64)'"
            "^(\s*checksumType64\s*=\s*)'.*'$"    = "`$1'$($Latest.ChecksumType64)'"
            "^(\s*validExitCodes\s*=\s*)@\(.*\)$" = "`$1@($($Latest.ValidExitCodes))"
        }
    }
}

Update-Package -ChecksumFor 64 -IncludeStream $IncludeStream -Force:$Force
