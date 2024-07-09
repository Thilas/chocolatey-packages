function Get-MergeTasks([hashtable] $pp) {
    $tasks = @()
    foreach($desktopicon in ('desktopicon','desktopicon\user','desktopicon\common')) {
        $tasks += '!'* $pp.NoDesktopIcon + $desktopicon
    }
    $tasks += '!'* $pp.NoQuicklaunchIcon + 'quicklaunchicon'
    $tasks += '!'* $pp.NoSetFileTypes    + 'associate_common'
    $tasks += '!'*!$pp.ResetDictionaries + 'reset_dictionaries'
    $tasks += '!'*!$pp.ResetSettings     + 'reset_settings'

    Write-Host "Merge Tasks: $tasks"
    return $tasks -join ','
}
