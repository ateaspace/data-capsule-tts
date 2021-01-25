# Setup and usage of MaryTTS for building a language
For this we use MaryTTS 5.x release as the newer versions of the software do not support language building.

When `MaryTTS` is mentioned in this document, it is assumed that we are referring to MaryTTS 5.x 

# Table of Contents
- [Install Prerequisites](#prerequisites) 
- [Installation of MaryTTS](#install)

# Prerequisites
MaryTTS requires atleast `JDK1.8` (we think), and thus is what we will use for this.

#### Install the relevant `JDK` if you do not have it:
```shell
> sudo apt-get install openjdk-8-jdk
> export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
> export PATH=$JAVA_HOME/bin:$PATH
```

#### Install `maven` if you do not have it:

Install maven:
```shell
> wget https://apache.inspire.net.nz/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
> tar xvzf apache-maven-3.6.3-bin.tar.gz
> cd apache-maven-3.6.3/
> cd bin/
> export PATH=`pwd`:$PATH
> cd ../..
```

If your worried about how much disk space maven will use while downloading packages:
```shell
> mkdir /Scratch/$USER/scratch-home
> export HOME=/Scratch/$USER/scratch-home
# Or a relevant directory
```

# Install
Now you have the dependencies, lets get and install `MaryTTS`:
```shell
> git clone https://github.com/marytts/marytts.git marytts-5x
> cd marytts-5x
> git checkout 5.x
> maven install
```

#### If you want to run the latest version and not `5.x`:
```shell
> git clone https://github.com/marytts/marytts.git marytts
> cd marytts
> ./gradew run
# Navigate to localhost:XXXX
# Where XXXX is port, generally defaults to 59125
```






