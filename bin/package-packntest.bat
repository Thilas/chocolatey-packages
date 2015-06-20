@cd "%~1"
@for %%f in (*.nupkg) do del /s /q "%%~f"
@for %%f in (*.nuspec) do call cinst --force --debug --verbose "%%~f"
@pause
