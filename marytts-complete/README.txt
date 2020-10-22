########
# Project recommends working with 5.x release if looking to use their language
# building tools

# For that, need older version of Java
#   JDK1.8 was found to be suitable but *not* JDK1.11

sudo apt-get install openjdk-8-jdk
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
export PATH=$JAVA_HOME/bin:$PATH

# Note:
##   JDK1.11 resulted in the following maven/JAXBException
##    [ERROR] Failed to execute goal org.apache.maven.plugins:maven-failsafe-plugin:2.20:integration-test (integration-test) on project marytts: Execution integration-test of goal org.apache.maven.plugins:maven-failsafe-plugin:2.20:integration-test failed: A required class was missing while executing org.apache.maven.plugins:maven-failsafe-plugin:2.20:integration-test: javax/xml/bind/JAXBException

#
# If you need maven:
#
  wget https://apache.inspire.net.nz/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
  tar xvzf apache-maven-3.6.3-bin.tar.gz 
  cd apache-maven-3.6.3/
  cd bin/
  export PATH=`pwd`:$PATH
  cd ../..

#
# If worried about how much disk space maven will use downloading packages
# into your home rea
#
  mkdir /Scratch/$USER/scratch-home
  export HOME=/Scratch/$USER/scratch-home


#
# Check out and compile tagged release 5.x
#

git clone https://github.com/marytts/marytts.git marytts-5x

cd marytts-5x
git checkout 5.x

maven install



########
# To run the latest version 

git clone https://github.com/marytts/marytts.git

cd marytts
./gradew run

Now visit localhost:XXXX//




