@echo off
cd "%~1"
for %%p in (*.nupkg) do rd /s /q "%ChocolateyInstall%\lib\%%~np"
call cinst --force --debug --verbose "%~n1"
pause
