$url = 'http://code.kliu.org/hashcheck/downloads/HashCheckInstall-2.1.11.exe'
Install-ChocolateyPackage 'hashcheck' 'exe' '/quiet' "$url" "$url"