@cd "%~1"
@for %%f in (*.nuspec) do call cuninst --debug --verbose "%%~nf"
@pause
