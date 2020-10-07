
sudo apt-get install make autoconf automake libtool pkg-config



git clone https://github.com/espeak-ng/pcaudiolib

  cd pcaudiolib/
  ./autogen.sh 
  ./configure --prefix /home/davidb/research/code-unmanaged/text-to-speech/eSpeak-ng-complete/linux
  make
  make install

git clone https://github.com/espeak-ng/espeak-ng.git


  ./autogen.sh 
  CFLAGS=-I/home/davidb/research/code-unmanaged/text-to-speech/eSpeak-ng-complete/linux/include  LDFLAGS=-L/home/davidb/research/code-unmanaged/text-to-speech/eSpeak-ng-complete/linux/lib  ./configure --prefix /home/davidb/research/code-unmanaged/text-to-speech/eSpeak-ng-complete/linux
  make
  make install



