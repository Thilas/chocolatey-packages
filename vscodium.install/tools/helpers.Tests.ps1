. ./helpers.ps1

# Get-MergeTasks tests

$result = [ordered] @{
    A1 = $(Get-MergeTasks) -eq 'desktopicon,quicklaunchicon,addcontextmenufiles,addcontextmenufolders,!associatewithfiles,addtopath,!runCode'
    A2 = $(Get-MergeTasks @{ NoQuicklaunchIcon = $true }) -eq 'desktopicon,!quicklaunchicon,addcontextmenufiles,addcontextmenufolders,!associatewithfiles,addtopath,!runCode'
    A3 = $(Get-MergeTasks @{ AssociateWithFiles = $true }) -eq 'desktopicon,quicklaunchicon,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath,!runCode'
    A4 = $(Get-MergeTasks @{ NoQuicklaunchIcon = $true; AssociateWithFiles = $true }) -eq 'desktopicon,!quicklaunchicon,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath,!runCode'
}
$result
