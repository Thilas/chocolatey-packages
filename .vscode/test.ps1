[CmdletBinding()]
param(
    [string[]] $ChocoParameters = ''
)

$ErrorActionPreference = 'Stop'

# Check if Windows Sandbox is enabled
if (!(Get-Command WindowsSandbox -ErrorAction SilentlyContinue)) {
    Write-Error @'
Windows Sandbox does not seem to be available. Check the following URL for prerequisites and further details:
https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-sandbox/windows-sandbox-overview

You can run the following command in an elevated PowerShell for enabling Windows Sandbox:
$ Enable-WindowsOptionalFeature -Online -FeatureName 'Containers-DisposableClientVM'
'@
}

# Close Windows Sandbox

$sandbox = Get-Process WindowsSandboxClient -ErrorAction SilentlyContinue
if ($sandbox) {
    '--> Closing Windows Sandbox'
    $sandbox | Stop-Process
    Start-Sleep -Seconds 5
}
Remove-Variable sandbox

# Initialize Temp Folder

$tempName = 'test'
$tempFolder = "$PSScriptRoot\temp\$tempName"
New-Item $tempFolder -ItemType Directory -ErrorAction SilentlyContinue | Out-Null

$packageName = if (Test-Path *.nuspec) {
    $metadata = ([xml] (Get-Content *.nuspec)).package.metadata
    $metadata.id
    $version = $metadata.version
}

# Create Bootstrap script
$bootstrapPs1FileName = 'Bootstrap.ps1'
$bootstraPath = "$tempFolder\$bootstrapPs1FileName"
@"
cd ~\Desktop
'--> Installing Chocolatey'
`$sw = [System.Diagnostics.Stopwatch]::StartNew()
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
'--> Chocolatey installed in {0}' -f `$sw.Elapsed
'--> Enabling automatic confirmation for Chocolatey'
choco feature enable -n=allowGlobalConfirmation
"@ > $bootstraPath
if ($packageName) {
    @"
'--> Installing $packageName.$version'
`$sw = [System.Diagnostics.Stopwatch]::StartNew()
choco install $packageName --version $version --source "$packageName;chocolatey" $ChocoParameters
'--> Package installed in {0}' -f `$sw.Elapsed
"@ >> $bootstraPath
}

# Create wsb file
$sandboxTestWsbFile = "$tempFolder\SandboxTest.wsb"
@"
<Configuration>
  <MappedFolders>
    <MappedFolder>
      <HostFolder>$tempFolder</HostFolder>
      <ReadOnly>true</ReadOnly>
    </MappedFolder>
    <MappedFolder>
      <HostFolder>$PWD</HostFolder>
    </MappedFolder>
  </MappedFolders>
  <LogonCommand>
    <Command>PowerShell Start-Process PowerShell -WindowStyle Maximized -WorkingDirectory '~\Desktop\$tempName' -ArgumentList '-ExecutionPolicy Bypass -NoExit -NoLogo -File $bootstrapPs1FileName'</Command>
  </LogonCommand>
</Configuration>
"@ > $sandboxTestWsbFile

@"
--> Starting Windows Sandbox, and:
  - Mounting the following directories:
    - $tempFolder
    - $PWD
  - Installing Chocolatey
"@
if ($packageName) {
    "  - Installing $packageName.$version"
}
WindowsSandbox $SandboxTestWsbFile
