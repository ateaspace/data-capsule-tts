# eSpeakEdit NG - Complete Package Setup

This package contains a standalone collection of libraries and packages required to run the [eSpeakEdit-NG](https://github.com/valdisvi/espeak-ng-espeakedit) program. The latest revision is setup to run **commit 7fe8e92** of the project.

This package uses `PulseAudio` as the audio output engine.

This package has been tested on the following configurations:
* Ubuntu 18.04 LTS w/ gcc 7.5.0

### Setup

To get this package running, you'll need a C compiler that supports C99, and a C++ compiler that supports C++11. Examples are gcc and g++.

You should only need to build once. To do so, source the `devel.bash` script and run `CASCADE-MAKE`. It is recommended to run this build in the background, as it will take some time.

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
    * [gtk-3.24.23](https://download.gnome.org/sources/gtk+/)
        * [jpeg-v9d](https://ijg.org)
        * [libpng-1.6.37](http://www.libpng.org/pub/png/libpng.html)
        * [libtiff-4.1.0](http://www.simplesystems.org/libtiff/)
        * [freetype-2.10.4](https://freetype.org)
        * (Not in use) [gobject-introspection-1.66.1](https://download.gnome.org/sources/gobject-introspection/)
            * [flex-2.6.3](https://github.com/westes/flex)
                * [bison-3.7.4](http://www.gnu.org/software/bison/)
        * [glib-2.67](https://download.gnome.org/sources/glib/)
            * [meson-0.56.0](https://mesonbuild.com/)
                * [python-3.9.0](https://www.python.org)
                    * [libffi-3.3](https://github.com/libffi/libffi)
                    * [openssl-1.1.1](https://www.openssl.org)
                * [ninja-1.10.1](https://github.com/ninja-build/ninja)
            * [libiconv-](https://www.gnu.org/software/libiconv/)
            * [zlib-1.2.11](https://zlib.net)
        * [pango-1.48.0](https://download.gnome.org/sources/pango/)
            * [fontconfig-2.13.92](https://www.freedesktop.org/wiki/Software/fontconfig/)
                * [gperf-3.1](https://www.gnu.org/software/gperf/)
            * [cairo-1.16.0](https://cairographics.org/download/)
                * [pixman-0.40.0](https://cairographics.org/releases/)
            * [harfbuzz-2.7.2](https://github.com/harfbuzz/harfbuzz)
        * [atk-2.36.0](https://download.gnome.org/sources/atk/)
        * [gdk-pixbuf-2.42.0](https://download.gnome.org/sources/gdk-pixbuf/)
            * [shared-mime-info-2.0](https://gitlab.freedesktop.org/xdg/shared-mime-info)
                * [glib]
                * [itstool-2.0.6](http://itstool.org/)
                    * [libxml2-2.9.7](http://www.xmlsoft.org/)
                        * [python-2.7.17](https://www.python.org)
                * (Not in use) [xmlto-0.0.28](https://pagure.io/xmlto)
        * [xkbcommon-1.0.3](https://xkbcommon.org)
        * [libxrender-0.9.10](https://gitlab.freedesktop.org/xorg/lib/libxrender)
        * [libxrandr-1.5.2](https://gitlab.freedesktop.org/xorg/lib/libxrandr)
            * [libxext-1.3.4](https://gitlab.freedesktop.org/xorg/lib/libxext)
        * [libxi-1.7.10](https://gitlab.freedesktop.org/xorg/lib/libxi)
            * [libxfixes-5.0.3](https://gitlab.freedesktop.org/xorg/lib/libxfixes)
        * [at-spi2-atk-2.38.0](https://gitlab.gnome.org/GNOME/at-spi2-atk)
            * [dbus-1.12.20](https://www.freedesktop.org/wiki/Software/dbus/)
                * [expat-2.2.10](https://libexpat.github.io)
            * [at-spi2-core-2.38.0](https://gitlab.gnome.org/GNOME/at-spi2-core)
                * [libXtst-1.2.3](https://gitlab.freedesktop.org/xorg/lib/libxtst)
        * [libepoxy-1.5.4](https://github.com/anholt/libepoxy)
        * [libx11-1.7.0](https://gitlab.freedesktop.org/xorg/lib/libx11)
            * [xorg-macros-1.19.2](https://gitlab.freedesktop.org/xorg/util/macros)
            * [libxtrans-1.4.0](https://gitlab.freedesktop.org/xorg/lib/libxtrans)
            * [xorgproto-2020.1](https://gitlab.freedesktop.org/xorg/proto/xorgproto)
            * [libxcb-1.14](https://gitlab.freedesktop.org/xorg/lib/libxcb)
                * [libxcbproto-1.14.1](https://gitlab.freedesktop.org/xorg/proto/xcbproto)
                * [libxau-1.0.9](https://gitlab.freedesktop.org/xorg/lib/libxau)
* [libcanberra-0.30](http://0pointer.de/lennart/projects/libcanberra/)
    * [libvorbis-1.3.7](https://xiph.org/downloads/)
        * [libogg-1.3.4](https://xiph.org/downloads/)

# Development Notes

* openssl is installed under its own prefix, as it compiles without certificate definitions. You will most likely need to build with the same version of openssl that is installed on your system
* xmlto is installed under its own prefix, owing to the fact that it causes build issues with various packages. The only package that requires xmlto as a hard dependency is shared-mime-info, which compiles fine