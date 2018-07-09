$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'strawberryperl'
    fileType       = 'msi'
    url            = 'http://strawberryperl.com/download/5.28.0.1/strawberry-perl-5.28.0.1-32bit.msi'
    url64bit       = 'http://strawberryperl.com/download/5.28.0.1/strawberry-perl-5.28.0.1-64bit.msi'
    silentArgs     = '/qn /norestart'
    checksum       = '652c5ade0785bf6745a6c0d61de2f28ba6caf8f5859f7c19915ebc65dd095667'
    checksumType   = 'sha256'
    checksum64     = '215fe9db4338904062065afaac9bf5cb7273c5fc6b943d0fdc60036df8755821'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
