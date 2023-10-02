function Get-MergeTasks([hashtable] $pp) {
    $tasks = @()
    $tasks += '!'* $pp.NoDesktopIcon           + 'desktopicon'
    $tasks += '!'* $pp.NoQuicklaunchIcon       + 'quicklaunchicon'
    $tasks += '!'* $pp.NoAddContextMenuFiles   + 'addcontextmenufiles'
    $tasks += '!'* $pp.NoAddContextMenuFolders + 'addcontextmenufolders'
    $tasks += '!'*!$pp.AssociateWithFiles      + 'associatewithfiles'
    $tasks += '!'* $pp.NoAddToPath             + 'addtopath'
    $tasks += '!'                              + 'runCode'

    Write-Host "Merge Tasks: $tasks"
    return $tasks -join ','
}

function Close-VSCodium {
    Get-Process 'VSCodium - Insiders' -ea 0 | ForEach-Object { $_.CloseMainWindow() | Out-Null }
    Start-Sleep 1
    Get-Process 'VSCodium - Insiders' -ea 0 | Stop-Process  #in case gracefull shutdown did not succeed, try hard kill
}
