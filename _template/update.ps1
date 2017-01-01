# IMPORTANT: Before releasing this package, copy/paste the next 2 lines into PowerShell to remove all comments from this file:
#   $f = 'C:\path\to\update.ps1'
#   gc $f | ? {$_ -notmatch "^\s*#"} | % {$_ -replace '(^.*?)\s*?[^``]#.*','$1'} | Out-File $f+".~" -en utf8; mv -fo $f+".~" $f

param([switch] $Force)

Import-Module au

function global:au_GetLatest {
  $fileType       = 'exe'
  # Uncomment matching EXE type (sorted by most to least common)
  #$silentArgs     = '/S'                                            # NSIS
  #$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
  #$silentArgs     = '/s'                                            # InstallShield
  #$silentArgs     = '/s /v"/qn"'                                    # InstallShield with MSI
  #$silentArgs     = '/s'                                            # Wise InstallMaster
  #$silentArgs     = '-s'                                            # Squirrel
  #$silentArgs     = '-q'                                            # Install4j
  #$silentArgs     = '-s -u'                                         # Ghost
  $validExitCodes = '0'
  #$fileType       = 'msi/msu'
  #$silentArgs    = "/qn /norestart /l*v ```"`$env:TEMP\`$env:chocolateyPackageName.`$env:chocolateyPackageVersion.MsiInstall.log```"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
  #$validExitCodes= @(0, 3010, 1641) # https://msdn.microsoft.com/en-us/library/aa376931(v=vs.85).aspx

  $uninstallSoftwareName   = 'Title *' # part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique.
  $uninstallFileType       = 'exe'
  # Uncomment matching EXE type (sorted by most to least common)
  #$uninstallSilentArgs     = '/S'                                            # NSIS
  #$uninstallSilentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
  #$uninstallSilentArgs     = '/s'                                            # InstallShield
  #$uninstallSilentArgs     = '/s /v"/qn"'                                    # InstallShield with MSI
  #$uninstallSilentArgs     = '/s'                                            # Wise InstallMaster
  #$uninstallSilentArgs     = '-s'                                            # Squirrel
  #$uninstallSilentArgs     = '-q'                                            # Install4j
  #$uninstallSilentArgs     = '-s -u'                                         # Ghost
  $uninstallValidExitCodes = '0'
  #$uninstallFileType       = 'msi'
  #$uninstallSilentArgs     = '/qn /norestart'
  #$uninstallValidExitCodes = '0, 3010, 1605, 1614, 1641' # https://msdn.microsoft.com/en-us/library/aa376931(v=vs.85).aspx

  $releasesUrl = 'https://api.github.com/repos/user/project/releases/latest'
  $releases = (Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing).Content | ConvertFrom-Json
  $version = $releases.tag_name -Match '^(.+)$'
  if (!$version) { throw 'Version not found.' }
  $version = $Matches[1]

  $urls = @($releases.assets | Where-Object name -Like "*$version*x86*.$fileType")
  if ($urls.Length -ne 1) { throw 'Url (x86) not found.' }
  $url32 = $urls[0].browser_download_url
  $urls = @($releases.assets | Where-Object name -Like "*$version*x64*.$fileType")
  if ($urls.Length -ne 1) { throw 'Url (x64) not found.' }
  $url64 = $urls[0].browser_download_url

  $checksumType = 'sha256'
  return @{
    Version                 = $version
    FileType                = $fileType
    Url32                   = $url32
    Url64                   = $url64
    SilentArgs              = $silentArgs
    ValidExitCodes          = $validExitCodes
    UninstallSoftwareName   = $uninstallSoftwareName
    UninstallFileType       = $uninstallFileType
    UninstallSilentArgs     = $uninstallSilentArgs
    UninstallValidExitCodes = $uninstallValidExitCodes
  }
}

function global:au_SearchReplace {
  @{
    'tools\chocolateyInstall.ps1' = @{
      "^(\s*packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
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
