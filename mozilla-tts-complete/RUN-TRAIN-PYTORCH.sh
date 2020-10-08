#!/bin/bash

python TTS-c7296b3/train.py --config_path data-pytorch/config-mtts.json | tee training.log
