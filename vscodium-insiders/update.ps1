[CmdletBinding()]
param([switch] $Force)

. "$PSScriptRoot.install\update.ps1" -Force:$Force

function global:au_SearchReplace {
    @{
        "$($Latest.PackageName).nuspec" = @{
            "(<dependency id=`"$($Latest.PackageName).install`" version=)`"[^`"]+`"" = "`$1`"[$($Latest.Version)]`""
        }
    }
}

Update-Package -ChecksumFor none -Force:$Force
