

export FESTIVAL_HOME=$PWD

if [ -d speech_tools/bin ] ; then
    echo "Adding in to PATH: speech_tools/bin"
    export PATH=$FESTIVAL_HOME/speech_tools/bin:$PATH    
fi


if [ -d festival/bin ] ; then
    echo "Adding in to PATH: festival/bin"
    export PATH=$FESTIVAL_HOME/festival/bin:$PATH    
fi


if [ -d festvox/src/ehmm/bin ] ; then
    echo "Adding in to PATH: festival/src/ehmm/bin"
    export PATH=$FESTIVAL_HOME/festvox/src/ehmm/bin:$PATH    
fi
