@cd "%~1"
@for %%f in (*.nupkg) do call cpush "%%~f"
@pause
