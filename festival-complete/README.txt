
wget -m -np "http://www.cstr.ed.ac.uk/downloads/festival/2.4/"
  rm www.cstr.ed.ac.uk/downloads/festival/2.4/index.html*
  mv www.cstr.ed.ac.uk/downloads/festival/2.4/* .

sudo apt-get install libncurses-dev

tar xvzf speech_tools-2.4-release.tar.gz 
  cd speech_tools/
  ./configure --prefix /home/davidb/research/code-unmanaged/text-to-speech/festival-complete/linux
  make
  make install
  cd ..


tar xvzf festival-2.4-release.tar.gz
  cd festival
  ./configure --prefix /home/davidb/research/code-unmanaged/text-to-speech/festival-complete/linux
  make
  make install
  cd ..
  

