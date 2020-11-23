# eSpeakEdit NG - Complete Package Setup

This package contains a standalone collection of libraries and packages required to run the [eSpeakEdit-NG](https://github.com/valdisvi/espeak-ng-espeakedit) program. The latest revision is setup to run **commit 7fe8e92** of the project.

This package uses `PulseAudio` as the audio output engine.

This package has been tested on the following configurations:
* Ubuntu 18.04 LTS w/ gcc 7.5.0

### Setup

To get this package running, you'll need a C compiler that supports C99, and a C++ compiler that supports C++11. Examples are gcc and g++.

You should only need to build once. To do so, source the `devel.bash` script and run `CASCADE-MAKE`

``` bash
source devel.bash
./CASCADE-MAKE.sh
```

Now the `espeak` command will be on your path, as long as you remain in the same shell. For future use, you should only have to source the `setup.bash` script.

```bash
source setup.bash
espeak ...
```

### Dependency Tree

* [make-4.3](https://www.gnu.org/software/make/)
* [automake-1.16.2](https://www.gnu.org/software/automake/)
    * [autoconf-2.69](https://www.gnu.org/software/autoconf/autoconf.html)
        * [m4-1.4.18](https://www.gnu.org/software/m4/m4.html)
* [libtool-2.4.6](https://www.gnu.org/software/libtool/)
* [pkg-config-0.29.2](https://www.freedesktop.org/wiki/Software/pkg-config/)
* [espeak-ng-1.50](https://github.com/espeak-ng/espeak-ng)
    * [pcaudiolib-1.1](https://github.com/espeak-ng/pcaudiolib/)
        * [pulseaudio-13.99.3](https://www.freedesktop.org/wiki/Software/PulseAudio/Download/)
            * [libsndfile-1.0.28](http://www.mega-nerd.com/libsndfile/)
            * [libatomic_ops-1.2](https://github.com/ivmai/libatomic_ops)
            * [speexdsp-1.2rc3](https://www.speex.org/downloads/)
            * [json-c-0.15-20200726](https://github.com/json-c/json-c)
                * [cmake-3.18.4](https://cmake.org/download/)
            * [gettext-0.21](https://www.gnu.org/software/gettext/)
* [portaudio-v190600](http://portaudio.com/)
* [sox-14.4.2](http://sox.sourceforge.net)
* [wxWidgets-3.0.5](https://www.wxwidgets.org/downloads/)
    * [gtk-3.]
        * [glib-2.67](https://download.gnome.org/sources/glib/)
            * [meson-0.56.0](https://mesonbuild.com/)
                * [python-3.9.0](https://www.python.org)
                    * [libffi-3.3](https://github.com/libffi/libffi)
                    * [openssl-1.1.1](https://www.openssl.org)
                * [ninja-1.10.1](https://github.com/ninja-build/ninja)
            * [libiconv-](https://www.gnu.org/software/libiconv/)
            * [zlib-1.2.11](https://zlib.net)
        * [shared-mime-info-](https://gitlab.freedesktop.org/xdg/shared-mime-info/)
            * [glib]
            * [itstool-2.0.6](http://itstool.org)
                * [libxml2-2.9.10](http://www.xmlsoft.org)
        * [jpeg-v9d](https://ijg.org)
        * [libpng-1.6.37](http://www.libpng.org/pub/png/libpng.html)
        * [libtiff-4.1.0](http://www.simplesystems.org/libtiff/)
        * [freetype-2.10.4](https://freetype.org)