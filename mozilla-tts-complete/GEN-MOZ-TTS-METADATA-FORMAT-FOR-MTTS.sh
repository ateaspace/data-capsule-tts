#!/bin/bash

if [ ! -d Data/MTTS ] ; then
    echo "Error: failed to find directroy Data/MTTS" 1>&2
    exit 1
fi

cd Data/MTTS

output_file=metadata.csv

echo ""
echo "****"
echo "* Generating metadata CSV file in format suitable for training with Mozilla TTS"
echo "****"

cat </dev/null > $output_file

for f in `ls -v text/*.txt` ; do
    f_tail=${f##*/}
    id=${f_tail%.*}
    
    echo "  Processing: $id"

    text=$(cat $f)
    
    echo "$id|$text|$text" >> $output_file
done

echo "****"
echo "* Generate file:"
echo "*   `pwd`/$output_file"
if [ ! -d 'wavs' ] ; then
    echo "* (Note: Mozilla expects audio files to be in 'wavs' subdirectory in Data/MTTS, not 'wav'"
fi
echo "****"

    
cd ../..
