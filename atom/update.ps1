[CmdletBinding()]
param($IncludeStream, [switch] $Force)

$base = Split-Path $PSScriptRoot -Leaf
. "$PSScriptRoot\..\$base.install\update.ps1" -IncludeStream $IncludeStream -Force:$Force

function global:au_SearchReplace {
    @{
        "$($Latest.PackageName).nuspec" = @{
            "(<dependency id=`"$($Latest.PackageName).install`" version=)`"[^`"]+`"" = "`$1`"[$($Latest.Version)]`""
        }
    }
}

Update-Package -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
