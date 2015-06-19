@echo off

where ketarin 1>nul 2>&1 || (
    echo Ketarin.exe not found on PATH. Please install Ketarin, e.g. by running
	echo choco install ketarin
	exit /b 1
)

for /f "tokens=1-3 delims=/ " %%a in ('date /t') do (set mydate=%%c%%b%%a)
for /f "tokens=1-2 delims=:" %%a in ('time /t') do (set mytime=%%a%%b)

del /s /q "C:\CODE\_work" 1>nul 2>&1
rd /s /q "..\_output" 1>nul 2>&1

ketarin /silent /install="%~1" /log="%~n1.%mydate%_%mytime%.log"
