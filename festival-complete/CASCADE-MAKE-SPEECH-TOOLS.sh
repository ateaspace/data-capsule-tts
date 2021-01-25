if [ ! -d $fest_download_dir ] 
then
    mkdir $fest_download_dir
    echo "Created festival directory | $fest_download_dir"

    wget -m -np "http://www.cstr.ed.ac.uk/downloads/festival/2.4/"
    rm www.cstr.ed.ac.uk/downloads/festival/2.4/index.html*
    mv www.cstr.ed.ac.uk/downloads/festival/2.4/* "$fest_download_dir/"
    rm -r -f $cur_dir/www.cstr.ed.ac.uk

    echo "Downloaded and untared the festival system"
fi

# Currently just building for speech tools at this point
if [ ! -d $fest_download_dir/speech_tools ]
then
    cd "$fest_download_dir"
    tar xvzf speech_tools-2.4-release.tar.gz 

    cd speech_tools/
    ./configure --prefix="$fest_download_dir"
    make
    make install
fi

if [ ! -d $fest_download_dir/festival ]
then
    # Need to give it ncurses or sometihng otherwise it fails
    export PATH=$install_dir/ncurses-5.9:$PATH

    cd "$fest_download_dir"
    tar xvzf festival-2.4-release.tar.gz 

    cd festival/
    ./configure --prefix="$fest_download_dir"
    make
    make install
fi

