#!/bin/bash

#train_set=12000
#val_set=1100

#train_set=1200
#val_set=110

train_set=120
val_set=11

echo "Generating training set with $train_set entries"
head -n $train_set Data/LJSpeech-1.1/metadata_shuf.csv > Data/LJSpeech-1.1/metadata_train.csv

echo "Generating val set with $val_set entries"
tail -n $val_set   Data/LJSpeech-1.1/metadata_shuf.csv > Data/LJSpeech-1.1/metadata_val.csv
