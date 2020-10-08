
#  The following article looks to describe the cutting edge training/modeling params

#    https://erogol.com/solving-attention-problems-of-tts-models-with-double-decoder-consistency/


####
# Switch to a python under your own control (e.g. through VirtualEnv)
####

  # sudo apt-get install python3-pip
  sudo apt-get install python3-venv

python3 -mvenv `pwd`/virtualenv-python3

  mkdir /mnt/disks/atea-scratch/davidb-home
  mkdir/mnt/disks/atea-scratch/tmp

export HOME=/mnt/disks/atea-scratch/davidb-home
export TMPDIR=/mnt/disks/atea-scratch/tmp

. virtualenv-python3/bin/activate

####


git clone https://github.com/mozilla/TTS.git TTS-c7296b3

git checkout c7296b3

# pip3 install wheel
## pip3 install torch

pip install -r requirements.txt

# python3 setup.py develop
python setup.py install


# sudo apt-get install espeak

#  # The following is probably already installed via requirements.txt, but safety first ...
#  pip3 install soundfile


# If looking to control version of tensorflow to match a model downloaded via gdown ...
# e.g., for TFlite example page that the time of writing

# pip install tensorflow==2.3.0rc0



cd ..


####
# Synthesize speech example
####

pwd

# /home/davidb/research/code-managed/data-capsule-tts/mozilla-tts-complete


#  https://github.com/mozilla/TTS/blob/master/notebooks/DDC_TTS_and_MultiBand_MelGAN_Example.ipynb

mkdir data-pytorch
pip install gdown

gdown --id 1dntzjWFg7ufWaTaFy80nRz-Tu02xWZos -O data-pytorch/tts_model.pth.tar
gdown --id 18CQ6G6tBEOfvCHlPqP8EBI4xWbrr9dBc -O data-pytorch/config.json

gdown --id 1Ty5DZdOc0F7OTGj9oJThYbL5iVu_2G0K -O data-pytorch/vocoder_model.pth.tar
gdown --id 1Rd0R_nRCrbjEdpOwq6XwZAktvugiBvmu -O data-pytorch/config_vocoder.json
gdown --id 11oY3Tv0kQtxK_JPgxrfesa99maVXHNxU -O data-pytorch/scale_stats.npy


./RUN-TTS-PYTORCH.py

# Takes a few seconds to run, generate as ouput:
#
#   test-pytorch--bill-got.wav


####
# Training
####


#  https://gist.github.com/erogol/97516ad65b44dbddb8cd694953187c5b
#
#  LJSpeech-1.1 is an example dataset of audio recordings used to train Mozilla TTS


  mkdir Data
  cd Data

  wget https://data.keithito.com/data/speech/LJSpeech-1.1.tar.bz2
  tar xvjf LJSpeech-1.1.tar.bz2 

  cd ..

./GEN-TRAIN-AND-VAL-SETS.sh 

  cd data-pytorch
  ./GEN-CONFIG-MTTS.sh
  cd ..
  
  mkdir Models
  mkdir Models/LJSpeech
  mkdir phoneme-cache



######

#scale_stats.npy

# erogol commented on 19 Aug
#
# scale stats is the mean spectrogram frame therefore anythong about spec. computation pertains it.
#
# You can compute it yourself using ```bin/compute_statistics.py`` for your dataset.
#
# I'll share the model I've trained which will include the file for LibriTTS


#######


cd TTS

  pip3 install wheel
  # pip3 install torch

  pip3 install -r requirements.txt

  python ./setup.py develop
# or ???
  python ./setup.py install





# To run some of the Jupyter notebooks


  sudo apt-get install jupyter

  # Need to set up virtual-env with Jupyter as a python kernel
  #   https://janakiev.com/blog/jupyter-virtual-envs/

  pwd
  # /home/davidb/research/code-unmanaged/text-to-speech/mozilla-tts-complete

  pip3 install ipykernel

  python3 -m ipykernel install --user --name=virtualenv-python3

  # Output something along the lines of:
  #   Installed kernelspec virtualenv-python3 in /mnt/disks/atea-scratch/davidb-home/.local/share/jupyter/kernels/virtualenv-python3

====
Text-to-Speech example

pwd

# /home/davidb/research/code-unmanaged/text-to-speech/mozilla-tts-complete

 mkdir data
 gdown --id 1p7OSEEW_Z7ORxNgfZwhMy7IiLE1s0aH7 -O data/tts_model.pkl
 gdown --id 18CQ6G6tBEOfvCHlPqP8EBI4xWbrr9dBc -O data/config.json
 gdown --id 1rHmj7CqD3Sfa716Y3ub_vpIBrQg_b1yF -O data/vocoder_model.pkl
 gdown --id 1Rd0R_nRCrbjEdpOwq6XwZAktvugiBvmu -O data/config_vocoder.json
 gdown --id 11oY3Tv0kQtxK_JPgxrfesa99maVXHNxU -O data/scale_stats.npy


=====
Training


