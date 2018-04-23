$ErrorActionPreference = 'Stop'

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'strawberryperl'
    fileType       = 'msi'
    url            = 'http://strawberryperl.com/download/5.26.2.1/strawberry-perl-5.26.2.1-32bit.msi'
    url64bit       = 'http://strawberryperl.com/download/5.26.2.1/strawberry-perl-5.26.2.1-64bit.msi'
    silentArgs     = '/qn /norestart'
    checksum       = 'd8e47b67b7dc826348443efd2204fa55acd365a24eee7016c2d9d9167aa624be'
    checksumType   = 'sha256'
    checksum64     = '41ca789c86db50b0d0af64fd7bff7816a51a20d22d145535f892ad2450a8b10b'
    checksumType64 = 'sha256'
    validExitCodes = @(0, 3010, 1641)
}
# *** Automatically filled ***

Install-ChocolateyPackage @packageArgs
