function Get-MergeTasks([hashtable] $pp) {
    $tasks = @()
    $tasks += '!'* $pp.NoDesktopIcon     + 'desktopicon'
    $tasks += '!'* $pp.NoDesktopIcon     + 'desktopicon\user'
    $tasks += '!'* $pp.NoDesktopIcon     + 'desktopicon\common'
    $tasks += '!'* $pp.NoQuicklaunchIcon + 'quicklaunchicon'
    $tasks += '!'* $pp.NoSetFileTypes    + 'associate_common'
    $tasks += '!'*!$pp.ResetDictionaries + 'reset_dictionaries'
    $tasks += '!'*!$pp.ResetSettings     + 'reset_settings'

    Write-Host "Merge Tasks: $tasks"
    return $tasks -join ','
}
