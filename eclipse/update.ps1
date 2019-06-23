[CmdletBinding()]
param($IncludeStream, [switch] $Force)

. "$PSScriptRoot\..\Common.ps1"

function global:au_GetLatest {
    return Get-Latest -ReleasesUrl 'https://wiki.eclipse.org/Simultaneous_Release' `
                      -TagNamesPattern '<th\b[^>]*>\s*.*\b(?<Release>\d+-\d+)\b.*\s*</th\b[^>]*>\s*<td\b[^>]*>\s*.*\b(?<TagName>\d+\.\d+)\b.*\s*</td\b' `
                      -LinkPattern '/downloads/packages/release/(?<Release>\d+-\d+)/r' `
                      -StreamFieldCount 2
}

function Get-Latest {
    [CmdletBinding()]
    param(
        [string] $ReleasesUrl,
        [string] $TagNamesPattern, # must include Release and TagName captures
        [string] $LinkPattern, # must include a Release capture
        [int] $StreamFieldCount
    )
    $releases = Invoke-WebRequest -Uri $ReleasesUrl -UseBasicParsing

    $tagNames = @{ }
    $result = $releases.Content | Select-String -Pattern $TagNamesPattern -AllMatches
    $result.Matches | % {
        $tagNames.Add($_.Groups['Release'].Value, $_.Groups['TagName'].Value)
    }

    $links = $releases.Links | ? { $_.href -match $LinkPattern -and $tagNames.Keys -contains $Matches.Release }

    $result = [ordered] @{}
    $links | % {
        $_.href -match $LinkPattern
        $release = $Matches.Release
        $tagName = $tagNames.$release
        $version = Get-Version $tagName

        $url = Get-Url $ReleasesUrl $_.href -ForceHttps
        $isUrl32 = if ($version -lt '4.10') { {
            param($Url)
            $Url -like "*jee*win32*" -and $Url -notlike '*x86_64*'
        } }
        $isUrl64 = if ($version -lt '4.10') { {
            param($Url)
            $Url -like "*jee*win32*" -and $Url -notlike '*x86_64*'
        } } else { {
            param($Url)
            $Url -like "*jee*win32*"
        } }

        $latest = Get-BasicLatest -ReleaseUrl $url `
                                  -GetTagName { $tagName } `
                                  -SkipTagName `
                                  -FileType 'zip' `
                                  -IsUrl32 $isUrl32 `
                                  -IsUrl64 $isUrl64 `
                                  -ForceHttps
        if ($latest.Url32) { $latest.Url32 += '&r=1' }
        if ($latest.Url64) { $latest.Url64 += '&r=1' }
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

Update-Package -ChecksumFor all -IncludeStream $IncludeStream -Force:$Force
