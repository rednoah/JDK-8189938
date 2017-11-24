# [JDK-8189938](https://bugs.openjdk.java.net/browse/JDK-8189938)
Exception in thread "Swing-Shell" java.lang.InternalError: Could not initialize COM: HRESULT=0x80010106


## Prerequisites

* **Windows 10** Fall Creators Update
* **JDK 9**
* Apache **Ant**
* **PowerShell** must be enabled and allowed to run scripts via `Settings ➔ For developers`. `get-java.ps1` is used to fetch the latest JRE which is then bundled with the app in the `APPX` package.


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
