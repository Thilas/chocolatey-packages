[CmdletBinding()]
param(
  [switch] $AllowLowerVersion,

  [ValidateSet('all', '32', '64', 'none')]
  [string] $ChecksumFor = 'all',

  [switch] $Force
)

Import-Module au

function global:au_GetLatest {
  $latest = getLatest
  CheckVersion $latest.Version
  return $latest
}

function global:au_SearchReplace {
  return searchReplace
}

function ToHttps([string] $url) {
  if ($url -and $url.StartsWith('http://')) {
    $url = $url.Insert(4, 's')
  }
  return $url
}

function CheckVersion([string] $remoteVersion) {
  $packageName = $global:Package.Name
  $nuspecVersion = $global:Package.NuspecVersion
  Write-Host "Checking $packageName version..."
  Write-Host "nuspec version: $nuspecVersion"
  Write-Host "remote version: $remoteVersion"

  if ($AllowLowerVersion -and !$Force -and $remoteVersion -ne $nuspecVersion) {
    $url = "https://chocolatey.org/packages/$packageName/$remoteVersion"
    try {
      Invoke-WebRequest $url
      Write-Host "New version detected but it already exists in the Chocolatey community feed:`n  $url"
      return
    } catch { }
    Write-Host 'New version detected. Forcing update...'
    $global:Package.NuspecVersion = '0.0'
  }
}

Update-Package -Result 'Package' -ChecksumFor $ChecksumFor -Force:$Force
