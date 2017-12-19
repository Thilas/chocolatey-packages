# <img src="https://cdn.rawgit.com/Thilas/chocolatey-packages/8e49b572ba0d78626a9cff9c09d932d76274795b/eclipse/icon.png" width="48" height="48"/> [Eclipse](https://chocolatey.org/packages/eclipse)

Eclipse is famous for our Java Integrated Development Environment (IDE), but our C/C++ IDE and PHP IDE are pretty cool too. You can easily combine language support and other features into any of our default packages, and the Eclipse Marketplace allows for virtually unlimited customization and extension.

### Eclipse IDE for Java EE Developers
Tools for Java developers creating Java EE and Web applications, including a Java IDE, tools for Java EE, JPA, JSF, Mylyn, EGit and others.

**This package includes:**

* Data Tools Platform
* Git integration for Eclipse
* Eclipse Java Development Tools
* Eclipse Java EE Developer Tools
* JavaScript Development Tools
* Maven Integration for Eclipse
* Mylyn Task List
* Eclipse Plug-in Development Environment
* Remote System Explorer
* Code Recommenders Tools for Java Developers
* Eclipse XML Editors and Tools

### Package Parameters
The following package parameters can be set:

* `/InstallationPath` or `/InstallLocation` - Where to install the binaries to - defaults to "`$Env:ProgramFiles\Eclipse Foundation\$packageVersion`"
* `/Multi-User` - Configure Eclipse as a multi-user install or not

These parameters can be passed to the installer with the use of `--params`.
For example: `--params "'/InstallationPath=C:\path\to\installation /Multi-User'"`.
