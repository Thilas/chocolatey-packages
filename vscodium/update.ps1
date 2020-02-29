[CmdletBinding()]
param([switch] $Force)

$base = Split-Path $PSScriptRoot -Leaf
. "$PSScriptRoot\..\$base.install\update.ps1"

function global:au_SearchReplace {
    @{
        "$($Latest.PackageName).nuspec" = @{
            "(<dependency id=`"$($Latest.PackageName).install`" version=)`"[^`"]+`"" = "`$1`"[$($Latest.Version)]`""
        }
    }
}

Update-Package -ChecksumFor none -Force:$Force
