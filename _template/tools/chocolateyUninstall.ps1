$file = "${Env:ProgramFiles}\Xxx\uninst.exe"
Uninstall-ChocolateyPackage 'xxx' 'exe/msi' '/silent' "$file" -validExitCodes @(0)

Try {
    $is64bits = Get-ProcessorBits 64
    If ($is64bits) {
        $file = "${Env:ProgramFiles(x86)}\Xxx\uninst.exe"
    } Else {
        $file = "${Env:ProgramFiles}\Subtitle Edit\uninst.exe"
    }
    Uninstall-ChocolateyPackage 'xxx' 'exe/msi' '/silent' "$file" -validExitCodes @(0)
    Write-ChocolateySuccess 'xxx'
} Catch {
    Write-ChocolateyFailure 'xxx' "$($_.Exception.Message)"
    Throw
}