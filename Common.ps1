$ErrorActionPreference = 'Stop'

if (!(Get-Module AU)) {
    Import-Module AU
}

# Returns a single stream from a web page using a regex pattern to get its version.
# A dedicated method can be used instead of the regex.
function Get-BasicLatest {
    [CmdletBinding()]
    [OutputType([hashtable])]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNull()]
        [uri] $ReleaseUri,
        [scriptblock] $GetTagName, # optional callback, param($Release)
        [string] $TagNamePattern, # optional, must include a TagName capture
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string] $FileType,
        [switch] $SkipTagName,
        [scriptblock] $IsUri32, # optional callback, param($Uri, $TagName, $Version)
        [scriptblock] $IsUri64, # optional callback, param($Uri, $TagName, $Version)
        [switch] $ForceHttps,
        [hashtable] $Latest = @{ } # optional
    )
    $release = Invoke-WebRequest -Uri $ReleaseUri -UseBasicParsing
    $release.Links | ForEach-Object {
        $_ | Add-Member 'BaseUri' $ReleaseUri
    }
    if ($GetTagName) {
        $tagName = & $GetTagName -Release $release
    } else {
        if ($release.Content -notmatch $TagNamePattern) {
            throw 'Tag name not found.'
        }
        $tagName = $Matches.TagName
        if (!$tagName) {
            throw 'Tag name not defined.'
        }
    }
    Write-Verbose "TagName: $tagName"
    $version = Get-Version $tagName
    Write-Verbose "Version: $version"
    $stream = @{ Version = $version }

    $pattern = "{0}$" -f [regex]::Escape(".$FileType")
    if (!$SkipTagName) {
        $pattern = "{0}.*$pattern" -f [regex]::Escape($tagName)
    }
    $links = $release.Links | Where-Object "href" -Match $pattern

    if ($IsUri32 -or !$IsUri64) {
        $uri = $links `
        | Get-Uri -ForceHttps:$ForceHttps `
        | Where-Object { !$IsUri32 -or (& $IsUri32 -Uri $_ -TagName $tagName -Version $version) } `
        | Assert-Uri -Type x86 -Version $version
        $stream += @{ Url32 = $uri }
        'Url32: {0}' -f $stream.Url32 | Write-Verbose
    }

    if ($IsUri64) {
        $uri = $links `
        | Get-Uri -ForceHttps:$ForceHttps `
        | Where-Object { & $IsUri64 -Uri $_ -TagName $tagName -Version $version } `
        | Assert-Uri -Type x64 -Version $version
        $stream += @{ Url64 = $uri }
        'Url64: {0}' -f $stream.Url64 | Write-Verbose
    }

    return $stream + $Latest
}

# Returns a single stream from one or multiple files. Archives are supported.
function Get-FileLatest {
    [CmdletBinding()]
    [OutputType([hashtable])]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNull()]
        [uri] $FileUri,
        [uri] $FileUri64,
        [switch] $Download,
        [string] $CompressedFile, # optional
        [scriptblock] $GetVersion, # optional callback, param($Response, $File)
        [switch] $ForceHttps,
        [hashtable] $Latest = @{ } # optional
    )
    $stream = @{ }
    if ($Download) {
        Remove-Item ($tempDirectory = New-TemporaryFile)
    }

    $FileUri, $FileUri64 `
    | Where-Object { $_ } `
    | ForEach-Object {
        try {
            $parameters = if ($Download) {
                New-Item $tempDirectory -ItemType Directory | Out-Null
                @{
                    Method   = 'Get'
                    OutFile  = Join-Path $tempDirectory $_.Segments[-1]
                    PassThru = $true
                }
            } else {
                @{ Method = 'Head' }
            }
            $response = Invoke-WebRequest -Uri $_ -UseBasicParsing @parameters

            $file = if ($Download) {
                if ($CompressedFile) {
                    $outPath = Join-Path $tempDirectory ([System.IO.Path]::GetFileNameWithoutExtension($_.Segments[-1]))
                    Expand-Archive -Path $parameters.OutFile -DestinationPath $outPath
                    $parameters.OutFile = Join-Path $outPath $CompressedFile
                    if (!(Test-Path $parameters.OutFile)) {
                        throw 'Compressed file not found.'
                    }
                }
                Get-Item $parameters.OutFile
            }

            $version = if ($GetVersion) {
                & $GetVersion -Response $response -File $file
            } else {
                Get-Version $response.BaseResponse.ResponseUri
            }
            if ($_ -ne $FileUri -and $version -ne $stream.Version) {
                throw ("Multiple versions found: {0} vs {1}." -f $version -ne $stream.Version)
            }
            Write-Verbose "Version: $version"

            $uri = Get-Uri -BaseUri $response.BaseResponse.ResponseUri -ForceHttps:$ForceHttps
            $stream += if ($_ -eq $FileUri) {
                @{
                    Version = $version
                    Url32   = $uri
                }
            } else {
                @{ Url64 = $uri }
            }
        } finally {
            if ($Download) { Remove-Item $tempDirectory -Recurse -Force }
        }
    }

    return $stream + $Latest
}

# Returns one or multiple streams from one or multiple web pages using its/their links to get all available versions.
function Get-LinksLatest {
    [CmdletBinding()]
    [OutputType([hashtable])]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNull()]
        [uri[]] $ReleasesUri,
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string] $FileType,
        [scriptblock] $IsLink, # optional callback, param($Link)
        [scriptblock] $GetVersion, # optional callback, param($Link)
        [int] $StreamFieldCount = 0, # optional, 0 means single stream
        [scriptblock] $IsUri32, # optional callback, param($Uri, $Version)
        [scriptblock] $IsUri64, # optional callback, param($Uri, $Version)
        [switch] $ForceHttps,
        [hashtable] $Latest = @{ } # optional
    )
    $links = $ReleasesUri | ForEach-Object {
        $releaseUri = $_
        $release = Invoke-WebRequest -Uri $releaseUri -UseBasicParsing
        $release.Links | ForEach-Object {
            $_ | Add-Member 'BaseUri' $releaseUri
        }
        $release.Links
    }

    $pattern = "{0}$" -f [regex]::Escape(".$FileType")
    $links = $links | Where-Object "href" -Match $pattern
    if ($IsLink) {
        $links = $links | Where-Object { & $IsLink -Link $_ }
    }
    if (!$GetVersion) {
        $GetVersion = { param($Link) Get-Version $Link.href }
    }
    $links | ForEach-Object {
        $version = & $GetVersion -Link $_
        $_ | Add-Member 'Version' $version
    }
    $streams = $links `
    | Where-Object "Version" `
    | Group-Object { $_.Version.ToString($StreamFieldCount) }
    if ($StreamFieldCount -ge 2) {
        $streams = $streams | Sort-Object { [version] $_.Name } -Descending
    } elseif ($StreamFieldCount -eq 1) {
        $streams = $streams | Sort-Object { [int] $_.Name } -Descending
    }

    function Get-Stream($stream, $links) {
        Write-Verbose "Stream: $stream"
        $release = $links `
        | Group-Object "Version" `
        | Sort-Object { Get-Version $_.Name } -Descending `
        | Select-Object -First 1
        if (!$release) {
            throw "Version not found for stream $stream."
        }
        $version = Get-Version $release.Name
        Write-Verbose "  Version: $version"
        $stream = @{ Version = $version }

        if ($IsUri32 -or !$IsUri64) {
            $uri = $release.Group `
            | Get-Uri -ForceHttps:$ForceHttps `
            | Where-Object { !$IsUri32 -or (& $IsUri32 -Uri $_ -Version $version) } `
            | Assert-Uri -Type x86 -Version $version
            $stream += @{ Url32 = $uri }
            '  Url32: {0}' -f $stream.Url32 | Write-Verbose
        }

        if ($IsUri64) {
            $uri = $release.Group `
            | Get-Uri -ForceHttps:$ForceHttps `
            | Where-Object { & $IsUri64 -Uri $_ -Version $version } `
            | Assert-Uri -Type x64 -Version $version
            $stream += @{ Url64 = $uri }
            '  Url64: {0}' -f $stream.Url64 | Write-Verbose
        }

        return $stream
    }

    $result = [ordered] @{ }
    $streams | ForEach-Object {
        $stream = Get-Stream $_.Name $_.Group
        $result.Add($_.Name, $stream)
    }
    if ($StreamFieldCount -eq 0) {
        return $result[0] + $Latest
    } else {
        return @{ Streams = $result } + $Latest
    }
}

# Returns one or multiple streams from a GitHub repository.
function Get-GitHubLatest {
    [CmdletBinding()]
    [OutputType([hashtable])]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string] $Repository,
        [scriptblock] $GetTagName, # optional callback, param($TagName, $Release)
        [int] $StreamFieldCount = 0, # optional, 0 means single stream
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string] $FileType,
        [scriptblock] $IsUri32, # optional callback, param($Uri, $TagName, $Version)
        [scriptblock] $IsUri64, # optional callback, param($Uri, $TagName, $Version)
        [hashtable] $Latest = @{ } # optional
    )
    $releases = Invoke-RestMethod -Uri "https://api.github.com/repos/$Repository/releases?per_page=10" -UseBasicParsing

    $releases | ForEach-Object {
        $tagName = $_.tag_name
        if ($GetTagName) {
            $tagName = & $GetTagName -TagName $tagName -Release $_
        }
        $version = Get-Version $tagName
        $_ | Add-Member 'Version' $version
    }
    $streams = $releases `
    | Where-Object "Version" `
    | Group-Object { $_.Version.ToString($StreamFieldCount) }
    if ($StreamFieldCount -ge 2) {
        $streams = $streams | Sort-Object { [version] $_.Name } -Descending
    } elseif ($StreamFieldCount -eq 1) {
        $streams = $streams | Sort-Object { [int] $_.Name } -Descending
    }

    function Get-Stream($stream, $releases) {
        Write-Verbose "Stream: $stream"
        $release = $releases `
        | Sort-Object "Version" -Descending `
        | Select-Object -First 1
        $tagName = $release.tag_name
        $version = $release.Version
        Write-Verbose "  Version: $version"
        $stream = @{ Version = $version }

        $pattern = "{0}.*{1}$" -f [regex]::Escape($tagName), [regex]::Escape(".$FileType")
        $assets = $release.assets | Where-Object "browser_download_url" -Match $pattern

        if ($IsUri32 -or !$IsUri64) {
            $uri = $assets `
            | ForEach-Object "browser_download_url" `
            | Where-Object { !$IsUri32 -or (& $IsUri32 -Uri $_ -TagName $tagName -Version $version) } `
            | Assert-Uri -Type x86 -Version $version
            $stream += @{ Url32 = $uri }
            '  Url32: {0}' -f $stream.Url32 | Write-Verbose
        }

        if ($IsUri64) {
            $uri = $assets `
            | ForEach-Object "browser_download_url" `
            | Where-Object { & $IsUri64 -Uri $_ -TagName $tagName -Version $version } `
            | Assert-Uri -Type x64 -Version $version
            $stream += @{ Url64 = $uri }
            '  Url64: {0}' -f $stream.Url64 | Write-Verbose
        }

        return $stream
    }

    $result = [ordered] @{ }
    $streams | ForEach-Object {
        $stream = Get-Stream $_.Name $_.Group
        $result.Add($_.Name, $stream)
    }
    if ($StreamFieldCount -eq 0) {
        return $result[0] + $Latest
    } else {
        return @{ Streams = $result } + $Latest
    }
}

function Assert-Uri {
    [CmdletBinding(DefaultParameterSetName="Default")]
    [OutputType([uri])]
    param(
        [Parameter(ValueFromPipeline=$true)]
        [uri] $Uri,
        [Parameter(Mandatory=$true, ParameterSetName="Default")]
        [ValidateNotNullOrEmpty()]
        [string] $Name,
        [Parameter(Mandatory=$true, ParameterSetName="TypeAndVersion")]
        [ValidateSet("x86", "x64")]
        [string] $Type,
        [Parameter(Mandatory=$true, ParameterSetName="TypeAndVersion")]
        [ValidateNotNullOrEmpty()]
        [object] $Version
    )
    begin {
        $uris = [System.Collections.Generic.HashSet[uri]]::new()
    }
    process {
        if ($Uri) {
            $uris.Add($Uri) | Out-Null
        }
    }
    end {
        if ($uris.Count -eq 0) {
            if ($Name) {
                throw "$Name not found."
            } else {
                throw "Url ($Type) not found for version $Version."
            }
        }
        if ($uris.Count -gt 1) {
            Write-Warning 'Urls:'
            $uris | ForEach-Object { Write-Warning "  - $_" }
            if ($Name) {
                throw "$Name has multiple values."
            } else {
                throw "Url ($Type) has multiple values for version $Version."
            }
        }
        return $uris | Select-Object
    }
}

function Get-Uri {
    [CmdletBinding()]
    [OutputType([uri])]
    param(
        [Parameter(ValueFromPipelineByPropertyName=$true)]
        [uri] $BaseUri,
        [Parameter(ValueFromPipelineByPropertyName=$true)]
        [Alias("href")]
        [string] $RelativeUrl,
        [switch] $ForceHttps
    )
    process {
        $uri = [uri]::new($BaseUri, $RelativeUrl)
        if ($ForceHttps -and $uri.Scheme -eq [uri]::UriSchemeHttp) {
            $builder = [System.UriBuilder]::new($uri)
            $builder.Scheme = [uri]::UriSchemeHttps
            if ($builder.Port -eq 80) {
                $builder.Port = 443
            }
            $uri = $builder.Uri
        }
        return $uri
    }
}
