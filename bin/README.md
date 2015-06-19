## Preparing `settings.xml` for this repo

People committing autopackages export their package-specific Ketarin `settings.xml`, which contains certain values that they used in their own setup. Some settings need to be in a specific way:

* Remove `Category`
* Set `TargetPath` to `C:\CODE\_work\`
* Remove `ExecuteCommand`, this is done externally
* Remove `HttpReferer`
* ... (everything else that's in the template)

These specific settings can be set [in a template](https://github.com/Thilas/chocolatey-packages/blob/master/bin/ketarin-template.xsl) so that these settings don't need to be fixed manually. Just apply the `xsl` to the exported `xml` settings in order to get the 'filtered' (AKA fixed) result.

Saxon Home Edition is used because most other tools only support `xslt 1.0` and __`xslt 2.0` is needed__ for the kind of magic used.

[__ketarin-filter-settings.bat__](https://github.com/Thilas/chocolatey-packages/blob/master/bin/ketarin-filter-settings.bat) (Windows)  

__Example usage:__

Imagine we have a 'tainted' `imdisk.ketarin.xml`. Running `ketarin-filter-settings.sh imdisk.ketarin.xml` will generate `imdisk.ketarin-fixed.xml`. This is what we want.
