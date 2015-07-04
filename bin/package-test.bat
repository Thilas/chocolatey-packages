@cd "%~1"
@for %%f in (*.nuspec) do rd /S /Q "%ChocolateyInstall%\lib\%%~nf"
@for %%f in (*.nupkg) do rd /S /Q "%ChocolateyInstall%\lib\%%~nf"
@for %%f in (*.nupkg) do call cinst --force --debug --verbose "%%~f"
@pause
