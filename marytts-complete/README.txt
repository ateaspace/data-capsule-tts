
# Project recommends working with 5.x release if looking to use their language
# building tools

# For that, need older version of Java
# JDK1.8 was found to be suitable (JDK1.11 resulted in a maven/Java Bean error)

sudo apt-get install openjdk-8-jdk
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
export PATH=$JAVA_HOME/bin:$PATH

# Check out and compile
git clone https://github.com/marytts/marytts.git marytts-5x

cd marytts-5x
git checkout 5.x

maven install



# To run the latest version

git clone https://github.com/marytts/marytts.git

cd marytts
./gradew run

Now visit localhost:XXXX//




