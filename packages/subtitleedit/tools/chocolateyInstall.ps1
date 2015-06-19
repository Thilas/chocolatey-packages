#$url32 = ''
##$url64 = ''
#Install-ChocolateyPackage 'subtitleedit' 'exe' '/verysilent' "$url32" "$url64"
Try {
    $fileName = 'SubtitleEdit-3.4.1-Setup'
    $url = "https://github.com/SubtitleEdit/subtitleedit/releases/download/3.4.1/$fileName.zip"
    $tempDir = Join-Path $env:TEMP 'chocolatey'
    $tempDir = Join-Path $tempDir 'subtitleedit'
    Install-ChocolateyZipPackage 'subtitleedit' "$url" "$tempDir"
    $file = Join-Path $tempDir "$fileName.exe"
    Install-ChocolateyInstallPackage 'subtitleedit' 'exe' '/VERYSILENT' "$file"
    Write-ChocolateySuccess 'subtitleedit'
} Catch {
    Write-ChocolateyFailure 'subtitleedit' "$($_.Exception.Message)"
    Throw 
}