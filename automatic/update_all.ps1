param($Name = $null, [switch] $Force)

Set-Location $PSScriptRoot

# Get-ChildItem _user\*.ps1 | ForEach-Object { . $_ }
# if (Test-Path update_vars.ps1) { . ./update_vars.ps1 }

$options = @{
  # Threads = 10
  # Timeout = 100
  Force   = $Force
  # Push    = $true

  <#Mail = if ($Env:mail_user) { @{
    To        = $Env:mail_user
    Server    = 'smtp.gmail.com'
    UserName  = $Env:mail_user
    Password  = $Env:mail_pass
    Port      = 587
    EnableSsl = $true
    } }#>

  # Gist_ID = $Env:Gist_ID

  <#Script = {
      param($Phase, $Info)

      if ($Phase -ne 'END') { return }

      Save-RunInfo
      Save-Gist
      Save-Git
  }#>
}

Update-AUPackages -Name $Name -Options $options | Format-Table
# $global:updateall = Import-CliXML $PSScriptRoot\update_info.xml

if ($updateall.error_count.total) { throw 'Errors during update' }
