https://github.com/mozilla/TTS/blob/master/notebooks/DDC_TTS_and_MultiBand_MelGAN_TFLite_Example.ipynb


 gdown --id 17PYXCmTe0el_SLTwznrt3vOArNGMGo5v -O data-lite/tts_model.tflite
 gdown --id 18CQ6G6tBEOfvCHlPqP8EBI4xWbrr9dBc -O data-lite/config.json
 gdown --id 1aXveT-NjOM1mUr6tM4JfWjshq67GvVIO -O data-lite/vocoder_model.tflite
 gdown --id 1Rd0R_nRCrbjEdpOwq6XwZAktvugiBvmu -O data-lite/config_vocoder.json
 gdown --id 11oY3Tv0kQtxK_JPgxrfesa99maVXHNxU -O data-lite/scale_stats.npy


git clone https://github.com/mozilla/TTS 

  git checkout c7296b3
  pip install -r requirements.txt
  python setup.py install
  pip install tensorflow==2.3.0rc0


