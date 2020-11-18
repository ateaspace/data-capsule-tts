# eSpeakEdit - Complete Package Setup

This package contains a standalone collection of libraries and packages required to run the [eSpeakEdit](http://espeak.sourceforge.net/index.html) program. The latest revision is setup to run **version 1.48.03** of eSpeakEdit.

This package has been tested on the following configurations:
* Ubuntu 18.04 LTS w/ gcc 7.5.0

### Setup

The only dependency you'll need preinstalled to get this package running is a functional c compiler.

You should only need to build once. To do so, source the `devel.bash` script and run `CASCADE-MAKE`

``` bash
source devel.bash
./CASCADE-MAKE.sh
```

Now the `espeakedit` command will be on your path, as long as you remain in the same shell. For future use, you should only have to source the `setup.bash` script.

```bash
source setup.bash
espeakedit ...
```

### Dependency Tree

* [libportaudio-v19-20111121]()
* [wxWidgets-2.9.3]()
    * [gtk2-]()
