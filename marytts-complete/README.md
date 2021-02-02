# Setup and usage of MaryTTS for building a language
For this we use MaryTTS 5.x release as the newer versions of the software do not support language building.

When `MaryTTS` is mentioned in this document, it is assumed that we are referring to MaryTTS 5.x 

# Table of Contents
- [Install Prerequisites](#prerequisites) 
- [Installation of MaryTTS](#install)
- [Creating a new language](#usage)

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
> mvn install
```

#### If you want to run the latest version and not `5.x`:
```shell
> git clone https://github.com/marytts/marytts.git marytts
> cd marytts
> ./gradew run
# Navigate to localhost:XXXX
# Where XXXX is port, generally defaults to 59125
```

# Usage
As a general rule of thumb, if you wish to create a HMM based language you should follow the following two guides:
[First Guide](https://github.com/marytts/marytts-wiki/blob/master/New-Language-Support.md)
[Second Guide](https://github.com/marytts/marytts-wiki/blob/master/HMMVoiceCreation.md)

The below steps note issues / quality of life additions that should help you out along during the process.

#### Maori Wikipedia (Step 1)
In order to complete step 1, you require an xml dump of your languages wikipedia. Due to the age of the tools, 2021 wikipedia downloads will not work and thus you should use an internet archive version.
We used [this](https://archive.org/details/miwiki_20100610). You will also need to bypass the `wkdb_download_wikidump` script and do the following:
- Download [this](https://archive.org/details/miwiki_20100610)
- Extract out the torrent so you have the `miwiki-latest-pages-articles.xml.bz2`
- Move that file to your wiki data directory 
- Create a backup, `cp miwiki-latest-pages-articles.xml.bz2 backup-miwiki-latest-pages-articles.xml.bz2` (Optional)
- Unzip it, `bunzip2 miwiki-latest-pages-articles.xml.bz2`

#### Working with MYSQL (Before step 2.2)
MaryTTS requires you run MYSQL 5.7, this version is no longer easily obtainable so we have created an easy way to install and setup the required stuff. This can be found [here](https://github.com/ateaspace/data-capsule-tts/tree/master/mysql-complete). Simply follow the instructions and you should be good to go.
*Note, if you are using the above MYSQL install. You will need to edit the following line in* `wkdb.conf`
`MYSQLHOST=localhost` should become `MYSQLHOST=localhost:6606`

When installing MYSQL from [here](https://github.com/ateaspace/data-capsule-tts/tree/master/mysql-complete) please take note to change the `MYSQL_USER` setting to `mary` and `MYSQL_ROOT_PASSWORD` to `wiki123`

#### Cleaning the database (After step 2.2)
MaryTTS still struggles to *properly* clean up the database correctly in step 2.2, due to this we built [this tool](https://github.com/ateaspace/data-capsule-tts/blob/master/marytts-complete/mysql_cleanup/word_cleaner.py) which should be run after step 2.2 has completed. Simply follow the prompts shown and you should be good to continue installation

#### Running the featuremaker (Before step 5)
MaryTTS  will attempt to create sentences n such out of your database text, however, you should [run this script](https://github.com/ateaspace/data-capsule-tts/blob/master/marytts-complete/mysql_cleanup/FeatureMakerCleaner.py) first in order to clean out the excessive 'web code' (Html, css, js, etc) that gets caught up in the database.

#### Database Selection (After step 6)
[This script](https://github.com/ateaspace/data-capsule-tts/blob/master/marytts-complete/mysql_cleanup/DatabaseSelection.py) aims to do what step 6 *should do*. This script will transfer the the correct database tables over so the following steps actually work.
