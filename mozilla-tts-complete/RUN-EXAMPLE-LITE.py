#!/usr/bin/env python

import os
import torch
import time
#import IPython

from TTS.tf.utils.tflite import load_tflite_model
from TTS.tf.utils.io import load_checkpoint
from TTS.utils.io import load_config
from TTS.utils.text.symbols import symbols, phonemes
from TTS.utils.audio import AudioProcessor
#from TTS.tts.utils.synthesis import synthesis
from TTS.utils.synthesis import synthesis

import scipy.io.wavfile

# runtime settings
use_cuda = False


# model paths
TTS_MODEL = "data-lite/tts_model.tflite"
TTS_CONFIG = "data-lite/config.json"
VOCODER_MODEL = "data-lite/vocoder_model.tflite"
VOCODER_CONFIG = "data-lite/config_vocoder.json"
STATS_PATH = 'data-lite/scale_stats.npy'


def run_vocoder(mel_spec):
  vocoder_inputs = mel_spec[None, :, :]
  # get input and output details
  input_details = vocoder_model.get_input_details()
  # reshape input tensor for the new input shape
  vocoder_model.resize_tensor_input(input_details[0]['index'], vocoder_inputs.shape)
  vocoder_model.allocate_tensors()
  detail = input_details[0]
  vocoder_model.set_tensor(detail['index'], vocoder_inputs)
  # run the model
  vocoder_model.invoke()
  # collect outputs
  output_details = vocoder_model.get_output_details()
  waveform = vocoder_model.get_tensor(output_details[0]['index'])
  return waveform 


def tts(model, text, CONFIG, p):
    t_1 = time.time()
    waveform, alignment, mel_spec, mel_postnet_spec, stop_tokens, inputs = synthesis(model, text, CONFIG, use_cuda, ap, speaker_id, style_wav=None,
                                                                             truncated=False, enable_eos_bos_chars=CONFIG.enable_eos_bos_chars,
                                                                             backend='tflite')
    waveform = run_vocoder(mel_postnet_spec.T)
    waveform = waveform[0, 0]
    rtf = (time.time() - t_1) / (len(waveform) / ap.sample_rate)
    tps = (time.time() - t_1) / len(waveform)
    print(waveform.shape)
    print(" > Run-time: {}".format(time.time() - t_1))
    print(" > Real-time factor: {}".format(rtf))
    print(" > Time per step: {}".format(tps))
    # IPython.display.display(IPython.display.Audio(waveform, rate=CONFIG.audio['sample_rate']))
    return alignment, mel_postnet_spec, stop_tokens, waveform, ap.sample_rate


# load configs
TTS_CONFIG = load_config(TTS_CONFIG)
VOCODER_CONFIG = load_config(VOCODER_CONFIG)

# load the audio processor
TTS_CONFIG.audio['stats_path'] = STATS_PATH
ap = AudioProcessor(**TTS_CONFIG.audio)

# LOAD TTS MODEL
# multi speaker 
speaker_id = None
speakers = []

# load the models
model = load_tflite_model(TTS_MODEL)
vocoder_model = load_tflite_model(VOCODER_MODEL)

sentence =  "Bill got in the habit of asking himself “Is that thought true?” and if he wasn’t absolutely certain it was, he just let it go."
align, spec, stop_tokens, wav, sample_rate = tts(model, sentence, TTS_CONFIG, ap)


output_wav_file = 'test-lite--bill-got.wav'

print("----")
print("Saved synthesized as: " + output_wav_file) 
print("----")
scipy.io.wavfile.write(output_wav_file, sample_rate, wav)
