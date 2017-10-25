# [JDK-8189938](https://bugs.openjdk.java.net/browse/JDK-8189938)
Exception in thread "Swing-Shell" java.lang.InternalError: Could not initialize COM: HRESULT=0x80010106

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
