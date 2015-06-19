$url32 = 'http://freefr.dl.sourceforge.net/project/stellarium/Stellarium-win32/0.13.0/stellarium-0.13.0-win32.exe'
#$url64 = 'http://freefr.dl.sourceforge.net/project/stellarium/Stellarium-win32/0.13.0/stellarium-0.13.0-win64.exe'
Install-ChocolateyPackage 'stellarium' 'exe' '/silent' "$url32" "$url64"