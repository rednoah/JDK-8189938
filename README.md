# [JDK-8189938](https://bugs.openjdk.java.net/browse/JDK-8189938)
Exception in thread "Swing-Shell" java.lang.InternalError: Could not initialize COM: HRESULT=0x80010106


## Prerequisites

* **Windows 10** Fall Creators Update
* **JDK 9**
* Apache **Ant**
* **PowerShell** must be enabled and allowed to run scripts via `Settings ➔ Update & Security ➔ For developers ➔ PowerShell ➔ Change execution policy ...  ➔ Apply`.
* **Developer mode** must be enabled via `Settings ➔ Update & Security ➔ For developers ➔ Developer mode` to allow unsigned APPX packages.


## Notes
During the first build `get-java.ps1` is used to fetch the latest JRE. This may take a few minutes. This JRE is bundled with the APPX package.


## Test Case

```bash
# Clone code
git clone https://github.com/rednoah/JDK-8189938.git
cd JDK-8189938
```

```bash
# Build and install
ant clean appx install
```

```bash
# Run
JDK8189938
```

This will launch the sample application via the UWP Desktop Bridge. Clicking on `Select File` should open a `JFileChooser` window but instead deadlocks the EDT and freezes the application.

![Screenshot](https://raw.githubusercontent.com/rednoah/JDK-8189938/master/screenshot.png)


## Solution

> It took much effort not to write what I'm thinking about VS 2013 right now.

This strange bug has been [thoroughly investigated](http://mail.openjdk.java.net/pipermail/swing-dev/2018-February/008323.html) by [Matthias Bläsing](https://github.com/matthiasblaesing) (Super Special Thanks!!). The solution is to [replace the Visual C++ runtime libraries](http://mail.openjdk.java.net/pipermail/swing-dev/2018-February/008351.html) included in JDK9 / VS2013 with patched ones.
