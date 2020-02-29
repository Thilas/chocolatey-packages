if (!(Get-Module AU)) {
    Import-Module AU
}

# Returns a single stream from a web page using a regex pattern to get its version.
# A dedicated method can be used instead of the regex.
function Get-BasicLatest {
    [CmdletBinding()]
    param(
        [string] $ReleaseUrl,
        [string] $TagNamePattern, # optional, must include a TagName capture
        [scriptblock] $GetTagName, # optional callback, param($Release)
        [switch] $SkipTagName,
        [string] $FileType,
        [scriptblock] $IsUrl32, # optional callback, param($Url, $TagName, $Version)
        [scriptblock] $IsUrl64, # optional callback, param($Url, $TagName, $Version)
        [switch] $ForceHttps,
        [hashtable] $Latest = @{} # optional
    )
    $release = Invoke-WebRequest -Uri $ReleaseUrl -UseBasicParsing
    if ($GetTagName) {
        $tagName = & $GetTagName -Release $release
    } else {
        if ($release.Content -notmatch $TagNamePattern) { throw 'Tag name not found.' }
        $tagName = $Matches.TagName
    }
    Write-Verbose "TagName: $tagName"
    $version = Get-Version $tagName
    Write-Verbose "Version: $version"
    $stream = @{ Version = $version }

    $links = $release.Links | ? { $_.href -like "*.$FileType" }
    if (!$SkipTagName) { $links = $links | ? { $_.href -like "*$tagName*" } }

    if ($IsUrl32 -or !$IsUrl64) {
        $urls = $links
        if ($IsUrl32) { $urls = $urls | ? { & $IsUrl32 -Url $_.href -TagName $tagName -Version $version } }
        $urls = @($urls | % { Get-Url $ReleaseUrl $_.href -ForceHttps:$ForceHttps } | select -Unique)
        if ($urls.Length -ne 1) {
            if ($urls) { Write-Verbose 'Urls:' }
            $urls | % { Write-Verbose "  - $_" }
            throw "Url (x86) not found for version $version."
        }
        $stream += @{ Url32 = $urls[0] }
        'Url32: {0}' -f $stream.Url32 | Write-Verbose
    }

    if ($IsUrl64) {
        $urls = $links | ? { & $IsUrl64 -Url $_.href -TagName $tagName -Version $version }
        $urls = @($urls | % { Get-Url $ReleaseUrl $_.href -ForceHttps:$ForceHttps } | select -Unique)
        if ($urls.Length -ne 1) {
            if ($urls) { Write-Verbose 'Urls:' }
            $urls | % { Write-Verbose "  - $_" }
            throw "Url (x64) not found for version $version."
        }
        $stream += @{ Url64 = $urls[0] }
        'Url64: {0}' -f $stream.Url64 | Write-Verbose
    }

    return $stream + $Latest
}

# Returns a single stream from a file using its ProductVersion or FileVersion.
# The file can be optionally extracted from an archive.
function Get-FileLatest {
    [CmdletBinding()]
    param(
        [string] $Uri,
        [string] $PathInArchive, # optional
        [hashtable] $Latest = @{} # optional
    )
    $tempPath = New-TemporaryFile
    Remove-Item $tempPath -Force
    $tempFile = Split-Path $Uri -Leaf
    $tempFile = "$tempPath\$tempFile"
    try {
        New-Item -Path $tempPath -ItemType Directory | Out-Null
        $release = Invoke-WebRequest -Uri $Uri -OutFile $tempFile

        if ($PathInArchive) {
            $outPath = New-TemporaryFile
            Remove-Item $outPath -Force
            New-Item -Path $outPath -ItemType Directory | Out-Null
            Expand-Archive -Path $tempFile -DestinationPath $outPath
            Remove-Item $tempPath -Recurse -Force
            $tempPath = $outPath
            $tempFile = "$outPath\$PathInArchive"
        }

        if (!(Test-Path $tempFile)) {
            throw 'File not found.'
        }
        $item = Get-Item -Path $tempFile
        $version = if ($item.VersionInfo.ProductVersion) {
            $item.VersionInfo.ProductVersion
        } else {
            $item.VersionInfo.FileVersion
        }
        $version = Get-Version $version
        Write-Verbose "Version: $version"

        $stream = @{
            Version = $version
            Url32   = $Uri
        }

        return $stream + $Latest
    } finally {
        if (Test-Path $tempPath) {
            Remove-Item $tempPath -Recurse -Force
        }
    }
}

# Returns one or multiple streams from one or multiple web pages using its/their links to get all available versions.
function Get-LinksLatest {
    [CmdletBinding()]
    param(
        [string[]] $ReleasesUrl,
        [scriptblock] $GetVersion, # optional callback, param($Url)
        [int] $StreamFieldCount = 0, # optional, 0 means single stream
        [string] $FileType,
        [scriptblock] $IsLink, # optional callback, param($Url)
        [scriptblock] $IsUrl32, # optional callback, param($Url, $Version)
        [scriptblock] $IsUrl64, # optional callback, param($Url, $Version)
        [switch] $ForceHttps,
        [hashtable] $Latest = @{} # optional
    )
    $links = @()
    foreach ($url in $ReleasesUrl) {
        $releases = Invoke-WebRequest -Uri $url -UseBasicParsing
        $releases.Links | % {
            $_ | Add-Member 'ReleasesUrl' $url
        }
        $links += $releases.Links
    }

    $links = $links | ? { $_.href -like "*.$FileType" }
    if ($IsLink) { $links = $links | ? { & $IsLink -Url $_.href } }
    if (!$GetVersion) { $GetVersion = { param($Url) Get-Version $Url } }
    $links | % {
        $version = & $GetVersion -Url $_.href
        $_ | Add-Member 'Version' $version
    }
    $streams = $links | ? Version | group { $_.Version.ToString($StreamFieldCount) }
    if ($StreamFieldCount -ge 2) {
        $streams = $streams | sort { [version] $_.Name } -Descending
    } elseif ($StreamFieldCount -eq 1) {
        $streams = $streams | sort { [int] $_.Name } -Descending
    }

    function Get-Stream($stream, $links) {
        Write-Verbose "Stream: $stream"
        $release = $links | group Version | sort { Get-Version $_.Name } -Descending | select -First 1
        if (!$release) { throw "Version not found for stream $stream." }
        $version = Get-Version $release.Name
        Write-Verbose "  Version: $version"
        $stream = @{ Version = $version }

        if ($IsUrl32 -or !$IsUrl64) {
            $urls = $release.Group
            if ($IsUrl32) { $urls = $urls | ? { & $IsUrl32 -Url $_.href -Version $version } }
            $urls = @($urls | % { Get-Url $_.ReleasesUrl $_.href -ForceHttps:$ForceHttps } | select -Unique)
            if ($urls.Length -ne 1) {
                if ($urls) { Write-Verbose 'Urls:' }
                $urls | % { Write-Verbose "  - $_" }
                throw "Url (x86) not found for version $version."
            }
            $stream += @{ Url32 = $urls[0] }
            '  Url32: {0}' -f $stream.Url32 | Write-Verbose
        }

        if ($IsUrl64) {
            $urls = $release.Group | ? { & $IsUrl64 -Url $_.href -Version $version }
            $urls = @($urls | % { Get-Url $_.ReleasesUrl $_.href -ForceHttps:$ForceHttps } | select -Unique)
            if ($urls.Length -ne 1) {
                if ($urls) { Write-Verbose 'Urls:' }
                $urls | % { Write-Verbose "  - $_" }
                throw "Url (x64) not found for version $version."
            }
            $stream += @{ Url64 = $urls[0] }
            '  Url64: {0}' -f $stream.Url64 | Write-Verbose
        }

        return $stream
    }

    $result = [ordered] @{}
    $streams | % {
        $stream = Get-Stream $_.Name $_.Group
        $result.Add($_.Name, $stream)
    }
    if ($StreamFieldCount -eq 0) {
        return ($result.Values | select -First 1) + $Latest
    } else {
        return @{ Streams = $result } + $Latest
    }
}

# Returns one or multiple streams from a GitHub repository.
function Get-GitHubLatest {
    [CmdletBinding()]
    param(
        [string] $Repository,
        [scriptblock] $GetTagName, # optional callback, param($TagName, $Release)
        [int] $StreamFieldCount = 0, # optional, 0 means single stream
        [string] $FileType,
        [scriptblock] $IsUrl32, # optional callback, param($Url, $TagName, $Version)
        [scriptblock] $IsUrl64, # optional callback, param($Url, $TagName, $Version)
        [hashtable] $Latest = @{} # optional
    )
    $releasesUrl = "https://api.github.com/repos/$Repository/releases?per_page=10"
    $releases = (Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing).Content | ConvertFrom-Json

    $releases | % {
        $tagName = $_.tag_name
        if ($GetTagName) {
            $tagName = & $GetTagName -TagName $tagName -Release $_
        }
        $version = Get-Version $tagName
        $_ | Add-Member 'Version' $version
    }
    $streams = $releases | ? Version | group { $_.Version.ToString($StreamFieldCount) }
    if ($StreamFieldCount -ge 2) {
        $streams = $streams | sort { [version] $_.Name } -Descending
    } elseif ($StreamFieldCount -eq 1) {
        $streams = $streams | sort { [int] $_.Name } -Descending
    }

    function Get-Stream($stream, $releases) {
        Write-Verbose "Stream: $stream"
        $release = $releases | sort Version -Descending | select -First 1
        $version = $release.Version
        Write-Verbose "  Version: $version"
        $stream = @{ Version = $version }

        $assets = $release.assets | ? { $_.browser_download_url -like "*{0}*.$FileType" -f $release.tag_name }

        if ($IsUrl32 -or !$IsUrl64) {
            $urls = $assets
            if ($IsUrl32) { $urls = $urls | ? { & $IsUrl32 -Url $_.browser_download_url -TagName $release.tag_name -Version $version } }
            $urls = @($urls | % browser_download_url | select -Unique)
            if ($urls.Length -ne 1) {
                if ($urls) { Write-Verbose 'Urls:' }
                $urls | % { Write-Verbose "  - $_" }
                throw "Url (x86) not found for version $version."
            }
            $stream += @{ Url32 = $urls[0] }
            '  Url32: {0}' -f $stream.Url32 | Write-Verbose
        }

        if ($IsUrl64) {
            $urls = $assets | ? { & $IsUrl64 -Url $_.browser_download_url -TagName $release.tag_name -Version $version }
            $urls = @($urls | % browser_download_url | select -Unique)
            if ($urls.Length -ne 1) {
                if ($urls) { Write-Verbose 'Urls:' }
                $urls | % { Write-Verbose "  - $_" }
                throw "Url (x64) not found for version $version."
            }
            $stream += @{ Url64 = $urls[0] }
            '  Url64: {0}' -f $stream.Url64 | Write-Verbose
        }

        return $stream
    }

    $result = [ordered] @{}
    $streams | % {
        $stream = Get-Stream $_.Name $_.Group
        $result.Add($_.Name, $stream)
    }
    if ($StreamFieldCount -eq 0) {
        return ($result.Values | select -First 1) + $Latest
    } else {
        return @{ Streams = $result } + $Latest
    }
}

function Get-Url([uri] $BaseUrl, [string] $RelativeUrl, [switch] $ForceHttps) {
    $url = [uri]::new($BaseUrl, $RelativeUrl).ToString()
    if ($ForceHttps -and $Url.StartsWith('http://')) { $url = $url.Insert(4, 's') }
    return $url
}
