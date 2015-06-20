@cd "%~1"
@for %%f in (*.nuspec) do rd /s /q "%ChocolateyInstall%\lib\%%~nf"
@for %%f in (*.nupkg) do rd /s /q "%ChocolateyInstall%\lib\%%~nf"
@for %%f in (*.nuspec) do call cinst --force --debug --verbose "%%~nf"
@pause
