
git clone https://github.com/mozilla/TTS.git

# sudo apt-get install python3-pip
sudo apt-get install python3-venv

python3 -mvenv `pwd`/virtualenv-python3

mkdir /mnt/disks/atea-scratch/davidb-home
mkdir/mnt/disks/atea-scratch/tmp

export HOME=/mnt/disks/atea-scratch/davidb-home
export TMPDIR=/mnt/disks/atea-scratch/tmp

. virtualenv-python3/bin/activate

cd TTS

  pip3 install wheel
  # pip3 install torch

  pip3 install -r requirements.txt

  python ./setup.py develop
# or ???
  python ./setup.py install


  sudo apt-get install espeak

  # The following is probably already installed via requirements.txt, but safety first ...
  pip3 install soundfile


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

  https://gist.github.com/erogol/97516ad65b44dbddb8cd694953187c5b

  LJSpeech-1.1 is an example dataset of audio recordings used to train Mozilla TTS
