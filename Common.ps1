Import-Module au

# Returns a single stream from a classic web page using a regex pattern to get its version.
# A dedicated method can be used instead of the regex.
function Get-BasicLatest {
  [CmdletBinding()]
  param(
    [string] $ReleaseUrl,
    [string] $TagNamePattern, # optional
    [scriptblock] $GetTagName, # optional callback, param($Release)
    [switch] $SkipTagName,
    [string] $FileType,
    [scriptblock] $IsUrl32, # optional callback, param($Url, $TagName, $Version, $Matches)
    [scriptblock] $IsUrl64, # optional callback, param($Url, $TagName, $Version, $Matches)
    [switch] $ForceHttps,
    [hashtable] $Latest = @{} #optional
  )
  $release = Invoke-WebRequest -Uri $ReleaseUrl -UseBasicParsing
  if ($GetTagName) {
    $tagName = & $GetTagName -Release $release
  } else {
    if ($release.Content -notmatch $TagNamePattern) { throw 'Tag name not found.' }
    $tagName = $Matches['tagName']
  }
  Write-Verbose ("TagName: {0}" -f $tagName)
  $version = Get-Version $tagName
  Write-Verbose ("Version: {0}" -f $version)

  $links = $release.Links | ? { $_.href -like "*.$FileType" }
  if (!$SkipTagName) { $links = $links | ? { $_.href -like "*$tagName*" } }

  $urls = $links
  if ($IsUrl32) { $urls = $urls | ? { & $IsUrl32 -Url $_.href -TagName $tagName -Version $version -Matches $Matches } }
  $urls = @($urls | % { $_.href } | select -Unique)
  if ($urls.Length -ne 1) {
    Write-Verbose 'Urls:'
    $urls | % { Write-Verbose "  - $_" }
    throw "Url (x86) not found for version $version."
  }
  $stream = @{
    Version = $version
    Url32   = Get-Url $ReleaseUrl $urls[0] -ForceHttps:$ForceHttps
  }
  Write-Verbose ("Url32: {0}" -f $stream.Url32)

  if ($IsUrl64) {
    $urls = $links | ? { & $IsUrl64 -Url $_.href -TagName $tagName -Version $version -Matches $Matches }
    $urls = @($urls | % { $_.href } | select -Unique)
    if ($urls.Length -ne 1) {
      Write-Verbose 'Urls:'
      $urls | % { Write-Verbose "  - $_" }
      throw "Url (x64) not found for version $version."
    }
    $stream += @{ Url64 = Get-Url $ReleaseUrl $urls[0] -ForceHttps:$ForceHttps }
    Write-Verbose ("Url64: {0}" -f $stream.Url64)
  }

  return $stream + $Latest
}

# Returns a single stream or multiple streams from a GitHub repository.
function Get-GitHubLatest {
  [CmdletBinding()]
  param(
    [string] $Repository,
    [int] $StreamFieldCount = 0, # optional, 0 means single stream
    [string] $FileType,
    [scriptblock] $IsUrl32, # optional callback, param($Url, $TagName, $Version)
    [scriptblock] $IsUrl64, # optional callback, param($Url, $TagName, $Version)
    [hashtable] $Latest = @{} # optional
  )
  $releasesUrl = "https://api.github.com/repos/$Repository/releases?per_page=10"
  $releases = (Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing).Content | ConvertFrom-Json
  $releases = $releases | sort { Get-Date -Date $_.published_at } -Descending
  $releases | % { $_ | Add-Member 'Version' (Get-Version $_.tag_name) }
  $streams = $releases | group { $_.Version.ToString($StreamFieldCount) }

  function Get-Stream($stream, $releases) {
    Write-Verbose ("Stream: {0}" -f $stream)
    $release = $releases | sort Version -Descending | select -First 1
    Write-Verbose ("  Date: {0}" -f $release.published_at)
    Write-Verbose ("  Version: {0}" -f $release.Version)
    $assets = $release.assets | ? { $_.browser_download_url -like ("*{0}*.$FileType" -f $release.tag_name) }

    $urls = $assets
    if ($IsUrl32) { $urls = $urls | ? { & $IsUrl32 -Url $_.browser_download_url -TagName $release.tag_name -Version $release.Version } }
    $urls = @($urls | % { $_.browser_download_url } | select -Unique)
    if ($urls.Length -ne 1) {
      Write-Verbose 'Urls:'
      $urls | % { Write-Verbose "  - $_" }
      throw "Url (x86) not found for version {0}." -f $release.Version
    }
    $stream = @{
      Version = $release.Version
      Url32   = $urls[0]
    }
    Write-Verbose ("  Url32: {0}" -f $stream.Url32)

    if ($IsUrl64) {
      $urls = $assets | ? { & $IsUrl64 -Url $_.browser_download_url -TagName $release.tag_name -Version $release.Version }
      $urls = @($urls | % { $_.browser_download_url } | select -Unique)
      if ($urls.Length -ne 1) {
        Write-Verbose 'Urls:'
        $urls | % { Write-Verbose "  - $_" }
        throw "Url (x64) not found for version {0}." -f $release.Version
      }
      $stream += @{ Url64 = $urls[0] }
      Write-Verbose ("  Url64: {0}" -f $stream.Url64)
    }

    return $stream
  }

  $result = [ordered] @{}
  $streams | % { $result.Add($_.Name, (Get-Stream $_.Name $_.Group)) }
  if ($StreamFieldCount -eq 0) {
    return ($result.Values | select -First 1) + $Latest
  } else {
    return @{ Streams = $result } + $Latest
  }
}

# Returns multiple streams from a classic web page using its links to get all available versions.
function Get-LinksLatest {
  [CmdletBinding()]
  param(
    [string] $ReleasesUrl,
    [int] $StreamFieldCount,
    [string] $FileType,
    [scriptblock] $IsLink, # optional callback, param($Url)
    [scriptblock] $IsUrl32, # optional callback, param($Url, $Version)
    [scriptblock] $IsUrl64, # optional callback, param($Url, $Version)
    [switch] $ForceHttps,
    [hashtable] $Latest = @{} # optional
  )
  $releases = Invoke-WebRequest -Uri $ReleasesUrl -UseBasicParsing

  $links = $releases.Links | ? { $_.href -like "*.$FileType" }
  if ($IsLink) { $links = $links | ? { & $IsLink -Url $_.href } }
  $links | % { $_ | Add-Member 'Version' (Get-Version $_.href) }
  $streams = $links | group { $_.Version.ToString($StreamFieldCount) }

  function Get-Stream($stream, $release) {
    Write-Verbose ("Stream: {0}" -f $stream)
    $versions = @($release | select -Unique 'Version' ) 
    if ($versions.Length -ne 1) { throw "Version not found for stream $stream." }
    $version = $versions[0].Version
    Write-Verbose ("  Version: {0}" -f $version)

    $urls = $release
    if ($IsUrl32) { $urls = $urls | ? { & $IsUrl32 -Url $_.href -Version $version } }
    $urls = @($urls | % { $_.href } | select -Unique)
    if ($urls.Length -ne 1) {
      Write-Verbose 'Urls:'
      $urls | % { Write-Verbose "  - $_" }
      throw "Url (x86) not found for version $version."
    }
    $stream = @{
      Version = $version
      Url32   = Get-Url $ReleasesUrl $urls[0] -ForceHttps:$ForceHttps
    }
    Write-Verbose ("  Url32: {0}" -f $stream.Url32)

    if ($IsUrl64) {
      $urls = $release | ? { & $IsUrl64 -Url $_.href -TagName $tagName -Version $version -Matches $Matches }
      $urls = @($urls | % { $_.href } | select -Unique)
      if ($urls.Length -ne 1) {
        Write-Verbose 'Urls:'
        $urls | % { Write-Verbose "  - $_" }
        throw "Url (x64) not found for version $version."
      }
      $stream += @{ Url64 = Get-Url $ReleasesUrl $urls[0] -ForceHttps:$ForceHttps }
      Write-Verbose ("  Url64: {0}" -f $stream.Url64)
    }

    return $stream
  }

  $result = [ordered] @{}
  $streams | % { $result.Add($_.Name, (Get-Stream $_.Name $_.Group)) }
  return @{ Streams = $result } + $Latest
}

function Get-Url([uri] $BaseUrl, [string] $RelativeUrl, [switch] $ForceHttps) {
    $url = [uri]::new($BaseUrl, $RelativeUrl).ToString()
    if ($ForceHttps -and $Url.StartsWith('http://')) { $url = $url.Insert(4, 's') }
    return $url
}
