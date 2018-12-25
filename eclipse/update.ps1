[CmdletBinding()]
param([switch] $Force)

. "$PSScriptRoot\..\Common.ps1"

function global:au_GetLatest {
    return Get-Latest -ReleasesUrl 'https://www.eclipse.org/downloads/packages/' `
                      -TagNamePattern 'Eclipse [\w-]+ \((?<TagName>[^)]+)\)' `
                      -LinkPattern '/downloads/packages/(release/[^/]+/(?<Build>\d+)(?<Revision>a)?)?' `
                      -VersionCount 3 `
                      -StreamFieldCount 2
}

function Get-Latest {
    [CmdletBinding()]
    param(
        [string] $ReleasesUrl,
        [string] $TagNamePattern, # must include a TagName capture
        [string] $LinkPattern, # must include Build and Revision captures
        [int] $VersionCount,
        [int] $StreamFieldCount
    )
    $releases = Invoke-WebRequest -Uri $ReleasesUrl -UseBasicParsing

    $links = $releases.Links | ? { $_.outerHTML -match $TagNamePattern -and $_.href -match $LinkPattern }
    $links = $links | select -First $VersionCount

    $result = [ordered] @{}
    $links | % {
        $_.outerHTML -match $TagNamePattern
        $tagName = $Matches.TagName
        $_.href -match $LinkPattern
        if ($Matches.Build) { $tagName += '.{0}' -f $Matches.Build }
        if ($Matches.Revision) { $tagName += '.1' }
        $version = Get-Version $tagName

        $url = Get-Url $ReleasesUrl $_.href -ForceHttps

        $latest = Get-BasicLatest -ReleaseUrl $url `
                                  -GetTagName { $version } `
                                  -SkipTagName `
                                  -FileType 'zip' `
                                  -IsUrl32 { param($Url, $Version) $Url -like "*jee*win32*" -and (
                                      $Url -notlike '*x86_64*' -or ($Version -ge '4.10' -and $Url -like '*x86_64*')
                                  )} `
                                  -IsUrl64 { param($Url) $Url -like "*jee*win32*" -and $Url -like '*x86_64*' } `
                                  -ForceHttps
        $latest.Url32 += '&r=1'
        $latest.Url64 += '&r=1'
        $result.Add($version.ToString($StreamFieldCount), $latest)
    }
    return @{ Streams = $result }
}
function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "^(\s*packageName\s*=\s*)'.*'$"    = "`$1'$($Latest.PackageName)'"
            "^(\s*url\s*=\s*)'.*'$"            = "`$1'$($Latest.Url32)'"
            "^(\s*url64bit\s*=\s*)'.*'$"       = "`$1'$($Latest.Url64)'"
            "^(\s*checksum\s*=\s*)'.*'$"       = "`$1'$($Latest.Checksum32)'"
            "^(\s*checksumType\s*=\s*)'.*'$"   = "`$1'$($Latest.ChecksumType32)'"
            "^(\s*checksum64\s*=\s*)'.*'$"     = "`$1'$($Latest.Checksum64)'"
            "^(\s*checksumType64\s*=\s*)'.*'$" = "`$1'$($Latest.ChecksumType64)'"
        }
    }
}

Update-Package -ChecksumFor all -Force:$Force
