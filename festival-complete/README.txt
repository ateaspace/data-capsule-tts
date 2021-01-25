
wget -m -np "http://www.cstr.ed.ac.uk/downloads/festival/2.4/"
  rm www.cstr.ed.ac.uk/downloads/festival/2.4/index.html*
  mv www.cstr.ed.ac.uk/downloads/festival/2.4/* .

sudo apt-get install libncurses-dev


FESTIVAL_HOME=$PWD

tar xvzf speech_tools-2.4-release.tar.gz 
  cd speech_tools/
  ./configure --prefix=$FESTIVAL_HOME/linux
  make
  make install
  cd ..


tar xvzf festival-2.4-release.tar.gz
  cd festival
  ./configure --prefix=$FESTIVAL_HOME/linux
  make
  make install
  cd ..
  

#====
# To create a new language model/voice, festvox is needed
#====

# Some useful URLS on the subject
#   https://github.com/marytts/marytts-wiki/blob/master/HMMVoiceCreation.md
#   http://festvox.org/download.html


wget "http://festvox.org/festvox-2.7/festvox-2.7.0-release.tar.gz"
#tar xvzf festival-2.4-release.tar.gz
tar xvzf festvox-2.7.0-release.tar.gz


# 'festvox' has lines of code that incorrectly test if an ifstream "== 0" to determine
#    if the open failed:

  ifstream fp_in;

  fp_in.open(argv[1], ios::in);

  if (fp_in == 0) {
    cout << "Cannot open file " << argv[1] << endl;
    exit(1);
  }


# Since 'fp_in' is an instanciated object (not a refererence to one) it is not correct to
#   be testing if this is equal to '0' (likely in the coder's mind, equall to 'NULL').
# The test should check to see if the ifstream is open, e.g.:

  if (!fp_in.is_open()) {
    ...
  }

# For more details on ifstream, see:
#  https://gehrcke.de/2011/06/reading-files-in-c-using-ifstream-dealing-correctly-with-badbit-failbit-eofbit-and-perror/


# The necessary changes to the source code have been tarred up and included here.
# A nicer solution would be to create a patch file for this, but for now the
# needed code changes can be spliced in with:

tar xvzf festvox-2.7.0-release--fixes.tar.gz
 

# To add 'speech_tools' and 'festival' binaries into your PATH
source ./SETUP.bash


# To allow for the more lax testing pointers against 0 that the code uses

export CFLAGS=-fpermissive
export CXXFLAGS=-fpermissive


# Compile up festvox

  cd festvox
  ./configure --prefix=$FESTIVAL_HOME/linux
  make
  cd ..


# Finally, source the SETUP.bash file again, so ehmm is added in to your PATH

source ./SETUP.bash




