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

* [make-4.3](https://www.gnu.org/software/make/)
* [automake-1.16.2](https://www.gnu.org/software/automake/)
    * [autoconf-2.69](https://www.gnu.org/software/autoconf/autoconf.html)
        * [m4-1.4.18](https://www.gnu.org/software/m4/m4.html)
* [libtool-2.4.6](https://www.gnu.org/software/libtool/)
* [pkg-config-0.29.2](https://www.freedesktop.org/wiki/Software/pkg-config/)
* [zlib-1.2.5](https://sourceforge.net/projects/libpng/files/zlib/) [Official Website](zlib.net)
* [libportaudio-v19-20111121](http://portaudio.com)
* [wxWidgets-2.9.3](https://www.wxwidgets.org)
    * [gtk2-2.24.32](https://www.gtk.org)
        * [glib-2.31.22](https://download.gnome.org/sources/glib/)
            * [libffi-3.0.10](https://github.com/libffi/libffi)
        * [libX11-1.6.0](https://gitlab.freedesktop.org/xorg/lib/libx11)
            * [xorg-macros-1.15.0](https://gitlab.freedesktop.org/xorg/util/macros/)
            * [libxtrans-1.2.5](https://gitlab.freedesktop.org/xorg/lib/libxtrans)
            * [xorg-proto-2018.1](https://gitlab.freedesktop.org/xorg/proto/xorgproto)
            * [libxcb-1.7](https://gitlab.freedesktop.org/xorg/lib/libxcb)
                * [xcbproto-1.6](https://gitlab.freedesktop.org/xorg/proto/xcbproto)
                * [libxau-1.0.6](https://gitlab.freedesktop.org/xorg/lib/libxau)
                * [pthread-stubs-0.3](https://gitlab.freedesktop.org/xorg/lib/pthread-stubs)
            * [perl-5.18.4](https://www.cpan.org/src/README.html)
        * [cairo-1.10.2](https://cairographics.org)
            * [libxrender-0.9.8](https://gitlab.freedesktop.org/xorg/lib/libxrender)
            * [pixman-0.18.4](https://cairographics.org/releases/)
            * [libpng-1.2.59](https://sourceforge.net/projects/libpng/files/)
            * [fontconfig-2.8.0](https://www.freedesktop.org/wiki/Software/fontconfig/)
                * [freetype-2.4.0](https://freetype.org)
        * [gdk-pixbuf-2.21.7](https://download.gnome.org/sources/gdk-pixbuf/)
            * [libtiff-4.0.10](https://download.osgeo.org/libtiff/old/)
                * [jpeg-8b](https://ijg.org)
        * [pango-1.28.4](https://download.gnome.org/sources/pango/)
        * [atk-2.4.0](https://download.gnome.org/sources/atk/)
* [espeak-1.48.04](http://espeak.sourceforge.net/index.html)
