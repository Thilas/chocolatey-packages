function Get-MergeTasks([hashtable] $pp) {
    $merge_tasks = @()
    $merge_tasks += '!'*$pp.NoDesktopIcon      + 'desktopicon'
    $merge_tasks += '!'*$pp.NoDesktopIcon      + 'desktopicon\user'
    $merge_tasks += '!'*$pp.NoDesktopIcon      + 'desktopicon\common'
    $merge_tasks += '!'*$pp.NoQuicklaunchIcon  + 'quicklaunchicon'
    $merge_tasks += '!'*$pp.NoSetFileTypes     + 'associate_common'
    $merge_tasks += '!'*!$pp.ResetDictionaries + 'reset_dictionaries'
    $merge_tasks += '!'*!$pp.ResetSettings     + 'reset_settings'

    Write-Host "Merge Tasks: $merge_tasks"
    return $merge_tasks -join ','
}
