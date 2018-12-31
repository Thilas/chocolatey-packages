# IMPORTANT: Before releasing this package, copy/paste the next 2 lines into PowerShell to remove all comments from this file:
#   $f = 'C:\path\to\update.ps1'
#   gc $f | ? {$_ -notmatch "^\s*#"} | % {$_ -replace '(^.*?)\s*?[^``]#.*','$1'} | Out-File $f+".~" -en utf8; mv -fo $f+".~" $f

[CmdletBinding()]
param($IncludeStream, [switch] $Force)

. "$PSScriptRoot\..\Common.ps1"

function global:au_GetLatest {
    $softwareName   = 'Title *' # part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique.
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
    #$silentArgs     = "/qn /norestart /l*v ```"`$env:TEMP\`$env:chocolateyPackageName.`$env:chocolateyPackageVersion.MsiInstall.log```"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
    #$validExitCodes = '0, 3010, 1641' # https://msdn.microsoft.com/en-us/library/aa376931(v=vs.85).aspx

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

    return Get-BasicLatest -ReleaseUrl 'https://' `
                           -TagNamePattern 'Version (?<TagName>[^ ]+) ' `
                           #-GetTagName { param($Release) '1.0.0' } `
                           #-SkipTagName `
                           -FileType $fileType `
                           #-IsUrl32 { param($Url, $TagName, $Version, $Matches) $Url -like '*x86*' } `
                           #-IsUrl64 { param($Url, $TagName, $Version, $Matches) $Url -like '*x64*' } `
                           #-ForceHttps `
                           -Latest @{
                               SoftwareName            = $softwareName
                               SilentArgs              = $silentArgs
                               ValidExitCodes          = $validExitCodes
                               UninstallFileType       = $uninstallFileType
                               UninstallSilentArgs     = $uninstallSilentArgs
                               UninstallValidExitCodes = $uninstallValidExitCodes
                           }
    return Get-GitHubLatest -Repository 'user/project' `
                            #-GetTagName { param($TagName, $Release) '1.0.0' } `
                            #-StreamFieldCount 2 `
                            -FileType $fileType `
                            #-IsUrl32 { param($Url, $TagName, $Version) $Url -like '*x86*' } `
                            #-IsUrl64 { param($Url, $TagName, $Version) $Url -like '*x64*' } `
                            -Latest @{
                                SoftwareName            = $softwareName
                                SilentArgs              = $silentArgs
                                ValidExitCodes          = $validExitCodes
                                UninstallFileType       = $uninstallFileType
                                UninstallSilentArgs     = $uninstallSilentArgs
                                UninstallValidExitCodes = $uninstallValidExitCodes
                            }
    return Get-LinksLatest -ReleasesUrl 'https://' `
                           -StreamFieldCount 2 `
                           -FileType $fileType `
                           #-IsLink { param($Url) $Url -like '*' } `
                           #-IsUrl32 { param($Url, $Version) $Url -like '*x86*' } `
                           #-IsUrl64 { param($Url, $Version) $Url -like '*x64*' } `
                           #-ForceHttps `
                           -Latest @{
                               SoftwareName            = $softwareName
                               SilentArgs              = $silentArgs
                               ValidExitCodes          = $validExitCodes
                               UninstallFileType       = $uninstallFileType
                               UninstallSilentArgs     = $uninstallSilentArgs
                               UninstallValidExitCodes = $uninstallValidExitCodes
                           }
}

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1'   = @{
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
        'tools\chocolateyUninstall.ps1' = @{
            "^([$]packageName\s*=\s*)'.*'$"       = "`$1'$($Latest.PackageName)'"
            "^([$]softwareName\s*=\s*)'.*'$"      = "`$1'$($Latest.SoftwareName)'"
            "^([$]fileType\s*=\s*)'.*'$"          = "`$1'$($Latest.UninstallFileType)'"
            "^([$]silentArgs\s*=\s*)'.*'$"        = "`$1'$($Latest.UninstallSilentArgs)'"
            "^([$]validExitCodes\s*=\s*)@\(.*\)$" = "`$1@($($Latest.UninstallValidExitCodes))"
        }
    }
}

# ChecksumFor: 'all', '32', '64', 'none'
Update-Package -ChecksumFor all -IncludeStream $IncludeStream -Force:$Force
