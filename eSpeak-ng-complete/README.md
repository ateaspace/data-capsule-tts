# eSpeak NG - Complete Package Setup

This package contains a standalone collection of libraries and packages required to run the [eSpeak NG](https://github.com/espeak-ng/espeak-ng) program. The latest revision is setup to run **version 1.50** of eSpeak NG.

This package builds eSpeak NG to use both `PulseAudio` and `Sonic`, and includes man pages/documentation via `ronn`/`kramdown`

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
* [pcaudiolib-1.1](https://github.com/espeak-ng/pcaudiolib/)
    * [pulseaudio-13.99.3](https://www.freedesktop.org/wiki/Software/PulseAudio/Download/)
        * [libsndfile-1.0.28](http://www.mega-nerd.com/libsndfile/)
        * [libatomic_ops-1.2](https://github.com/ivmai/libatomic_ops)
        * [speexdsp-1.2rc3](https://www.speex.org/downloads/)
        * [json-c-0.15-20200726](https://github.com/json-c/json-c)
            * [cmake-3.18.4](https://cmake.org/download/)
        * [gettext-0.21](https://www.gnu.org/software/gettext/)