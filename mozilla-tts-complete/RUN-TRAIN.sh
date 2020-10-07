#!/bin/bash

python TTS/train.py --config_path data-lite/config-atea.json | tee training.log
