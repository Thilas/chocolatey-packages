@echo off
cd "%~1"
for %%p in (*.nupkg) do call cpush "%%p"
pause
