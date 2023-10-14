[CmdletBinding()]
param($IncludeStream, [switch] $Force)

. "$PSScriptRoot\..\Common.ps1"

function global:au_GetLatest {
    Get-Latest `
        -ReleasesUri 'https://raw.githubusercontent.com/eclipse-simrel/.github/main/wiki/Simultaneous_Release.md' `
        -TagNamePattern '<tr class="\w+">\s*<td><p>[\s\S]*?\b(?<Release>\d+-\d+)\b[\s\S]*?</p></td>\s*<td><p>[\s\S]*?\b(?<TagName>\d+\.\d+)\b[\s\S]*?</p></td>' `
        -LinkPattern '\bhref="(?<Url>https://www.eclipse.org/downloads/packages/release/(?<Release>\d+-\d+)/r)"' `
        -StreamFieldCount 2
}

function Get-Latest {
    [CmdletBinding()]
    param(
        [uri] $ReleasesUri,
        [string] $TagNamePattern, # must include Release and TagName captures
        [string] $LinkPattern,    # must include Url and Release captures
        [int] $StreamFieldCount
    )
    $releases = Invoke-WebRequest -Uri $ReleasesUri -UseBasicParsing

    # Let's remove HTML comments first
    $content = $releases.Content -replace '<!--[\s\S]*?-->', ''

    $tagNames = @{ }
    $content `
    | Select-String -Pattern $TagNamePattern -AllMatches `
    | ForEach-Object Matches `
    | Select-Object -First 10
    | ForEach-Object {
        $tagNames.Add($_.Groups['Release'].Value, $_.Groups['TagName'].Value)
    }

    $result = [ordered] @{ }
    $content `
    | Select-String -Pattern $LinkPattern -AllMatches `
    | ForEach-Object Matches `
    | Where-Object {
        $tagNames.ContainsKey($_.Groups['Release'].Value)
    } `
    | ForEach-Object {
        $release = $_.Groups['Release'].Value
        $tagName = $tagNames.$release
        $version = Get-Version $tagName

        $uri = Get-Uri -BaseUri $_.Groups['Url'].Value -ForceHttps
        $isUri32 = if ($version -lt '4.10') {
            { param($Uri) $Uri -match "\bjee\b.*\bwin32\b" -and $Uri -notmatch '\bx86_64\b' }
        }
        $isUri64 = if ($version -lt '4.10') {
            { param($Uri) $Uri -match "\bjee\b.*\bwin32\b" -and $Uri -notmatch '\bx86_64\b' }
        } else {
            { param($Uri) $Uri -match "\bjee\b.*\bwin32\b" }
        }

        $latest = Get-BasicLatest `
            -ReleaseUri $uri `
            -GetTagName { $tagName } `
            -FileType 'zip' `
            -SkipTagName `
            -IsUri32 $isUri32 `
            -IsUri64 $isUri64 `
            -ForceHttps
        # Fix download urls and test if available, otherwise let's skip the release for now
        if (!(Resolve-Url $latest Url32)) { return }
        if (!(Resolve-Url $latest Url64)) { return }
        $result.Add($version.ToString($StreamFieldCount), $latest)
    }
    return @{ Streams = $result }
}

function Resolve-Url {
    [CmdletBinding()]
    [OutputType([bool])]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNull()]
        [hashtable] $Latest,
        [Parameter(Mandatory)]
        [ValidateSet("Url32", "Url64")]
        [string] $Property
    )
    if ($Latest.$Property) {
        $Latest.$Property = '{0}&r=1' -f $Latest.$Property
        try {
            Invoke-WebRequest -Uri $Latest.$Property -UseBasicParsing -Method Head
        } catch {
            return $false
        }
    }
    return $true
}

function global:au_BeforeUpdate {
    if ($Latest.Url32) {
        $Latest.ChecksumType32 = 'sha256'
        $Latest.Checksum32 = Get-RemoteChecksum -Url $Latest.Url32 -Algorithm $Latest.ChecksumType32
    }
    if ($Latest.Url64) {
        $Latest.ChecksumType64 = 'sha256'
        $Latest.Checksum64 = Get-RemoteChecksum -Url $Latest.Url64 -Algorithm $Latest.ChecksumType64
    }
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

Update-Package -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
