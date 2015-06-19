$url32 = 'http://freefr.dl.sourceforge.net/project/areca/areca-stable/areca-7.3.6/areca-7.3.6-windows-jre32-setup.exe'
$url64 = 'http://freefr.dl.sourceforge.net/project/areca/areca-stable/areca-7.3.6/areca-7.3.6-windows-jre64-setup.exe'
Install-ChocolateyPackage 'areca' 'exe' '' "$url32" "$url64"