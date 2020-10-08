#!/bin/bash

#train_set=12000
#val_set=1100

train_set=1200
val_set=110

#train_set=120
#val_set=11

ljspeech_dir=Data/LJSpeech-1.1

if [ ! -f $ljspeech_dir/metadata_shuf.csv ] ; then
    echo "Generating shuffled dataset: $ljspeech_dir/metadata_shuf.csv"
    shuf $ljspeech_dir/metadata.csv > $ljspeech_dir/metadata_shuf.csv
fi


echo "Generating training set with $train_set entries: $ljspeech_dir/metadata_train.csv"
head -n $train_set $ljspeech_dir/metadata_shuf.csv > $ljspeech_dir/metadata_train.csv

echo "Generating val set with $val_set entries: $ljspeech_dir/metadata_val.csv"
tail -n $val_set   $ljspeech_dir/metadata_shuf.csv > $ljspeech_dir/metadata_val.csv
