@echo off
cd "%~1"
for %%p in (*.nupkg) do rd /S /Q "%ChocolateyInstall%\lib\%%~np"
call cinst --force --debug --verbose "%~n1" --source "%cd%"
pause
