function Uninstall-ChocolateyShortcut {
<#
.SYNOPSIS
Remove a shortcut
.DESCRIPTION
This deletes a shortcut, at the specified location.
.NOTES
If this errors, as it may if being run under the local SYSTEM account with
particular folder that SYSTEM doesn't have, it will display a warning instead
of failing a package installation.
.INPUTS
None
.OUTPUTS
None
.PARAMETER ShortcutFilePath
The full absolute path to where the shortcut is.
.PARAMETER UnpinFromTaskbar
OPTIONAL - Unpin the shortcut from the taskbar.
.PARAMETER IgnoredArguments
Allows splatting with arguments that do not apply. Do not use directly.
.EXAMPLE
>
# This will remove a shortcut at the location of "C:\test.lnk"
Uninstall-ChocolateyShortcut -ShortcutFilePath "C:\test.lnk"
.EXAMPLE
>
# Removes a notepad shortcut on the root of C:.
# Shortcut is also unpinned from taskbar.
Uninstall-ChocolateyShortcut `
  -ShortcutFilePath "C:\notepad.lnk" `
  -UnpinFromTaskbar
#>
  param(
    [parameter(Mandatory=$true, Position=0)][string] $shortcutFilePath,
    [parameter(Mandatory=$false)][switch] $UnpinFromTaskbar,
    [parameter(ValueFromRemainingArguments = $true)][Object[]] $ignoredArguments
  )

  Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

  if (!$shortcutFilePath) {
    # shortcut file path could be null if someone is trying to get special
    # paths for LocalSystem (SYSTEM).
    Write-Warning "Unable to remove shortcut. `$shortcutFilePath can not be null."
    return
  }

  try {
    if ($UnpinFromTaskbar) {
      if (Test-Path $shortcutFilePath) {$pinverb = (New-Object -com "shell.application").namespace($(split-path -parent $shortcutFilePath)).Parsename($(split-path -leaf $shortcutFilePath)).verbs() | ?{$_.Name -eq 'Unpin from tas&kbar'}}
      if ($pinverb) {$pinverb.doit()}
    }

    Write-Debug "Removing Shortcut..."
    Remove-Item -Path "$shortcutFilePath" -ErrorAction SilentlyContinue -Force
    Write-Debug "Shortcut removed."
  }
  catch {
    Write-Warning "Unable to remove shortcut. Error captured was $($_.Exception.Message)."
  }
}