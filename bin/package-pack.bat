@echo off
cd "%~1"
for %%p in (*.nupkg) do del "%%~p"
call cpack "%~n1.nuspec"
pause
