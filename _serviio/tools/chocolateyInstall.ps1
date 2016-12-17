$url32 = 'http://download.serviio.org/releases/serviio-1.3.1-win-setup.exe'
#$url64 = 'http://download.serviio.org/releases/serviio-1.3.1-win-setup.exe'
Install-ChocolateyPackage 'serviio' 'exe' '' "$url32" "$url64"