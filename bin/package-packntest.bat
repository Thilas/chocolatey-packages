@echo off
cd "%~1"
for %%p in (*.nupkg) do del "%%~p"
call cinst --force --debug --verbose "%~n1.nuspec"
pause
