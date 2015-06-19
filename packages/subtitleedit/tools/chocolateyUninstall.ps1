Try {
    $is64bits = Get-ProcessorBits 64
    If ($is64bits) {
        $file = "${Env:ProgramFiles(x86)}\Subtitle Edit\unins000.exe"
    } Else {
        $file = "${Env:ProgramFiles}\Subtitle Edit\unins000.exe"
    }
    Uninstall-ChocolateyPackage 'subtitleedit' 'exe' '/VERYSILENT' "$file" -validExitCodes @(0)
    Write-ChocolateySuccess 'subtitleedit'
} Catch {
    Write-ChocolateyFailure 'subtitleedit' "$($_.Exception.Message)"
    Throw
}